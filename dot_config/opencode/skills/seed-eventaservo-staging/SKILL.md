---
name: seed-eventaservo-staging
description: >-
  Use quando o usuário pedir para popular o banco de dados de staging do
  eventaservo com eventos de exemplo em Esperanto. Cria eventos passados e
  futuros, com variedade de países, formatos (online/presencial/híbrido),
  e tags (Unutaga/Plurtaga, Kunveno/Kurso/Alia).
  Também ativa quando mencionar 'popular', 'seed', 'eventos de exemplo',
  'povoar banco', ou 'criar eventos no eventaservo'.
---

# Seed Eventaservo Staging

Popula o banco staging do eventaservo com eventos realistas em Esperanto.

## Servidor

- **Host**: `srv2` (SSH config: `srv2.shayani.net` porta 2205, user `shayani`)
- **Container Docker**: `eventaservo-staging_backend.1.<sufixo>` (sufixo varia — use `docker ps --filter name=eventaservo-staging_backend` para descobrir)
- **RAILS_ENV**: `staging` (já configurado no container)
- **Rails console**: `bin/rails runner` (no workdir `/eventaservo`)

## Pré-requisitos

- SSH configurado (`srv2` no `~/.ssh/config`)
- Acesso ao container Docker no servidor
- `docker`, `scp` disponíveis localmente

## Dados do Banco

### Usuário

| ID | Nome | Email |
|----|------|-------|
| 998628195 | Administranto | admin@eventaservo.org |
| 227792459 | Standard user | standard@user.com |
| 998628196 | EventaServo Sistemo | kontakto@eventaservo.org |
| 998628199 | Yves Nevelsteen | yves@eventaservo.org |

### Tags (IDs fixos — usados nos scopes)

| ID | Nome | group_name |
|----|------|-----------|
| 722219490 | Kunveno/Evento | category |
| 977996592 | Kurso | category |
| 765066271 | Alia | category |
| 649720229 | Anonco | characteristic |
| 466275732 | Konkurso | characteristic |
| 656371181 | Por junuloj | characteristic |
| 498146071 | Unutaga | time |
| 551058890 | Plurtaga | time |

### Countries relevantes (seleção)

| ID | Nome (Esperanto) | Code |
|----|-----------------|------|
| 30 | Brazilo | br |
| 58 | Francio | fr |
| 62 | Germanio | de |
| 33 | Britio | gb |
| 86 | Italio | it |
| 76 | Hispanio | es |
| 173 | Pollando | pl |
| 79 | Hungario | hu |
| 95 | Kanado | ca |
| 88 | Japanio | jp |
| 234 | Usono | us |
| 21 | Belgio | be |
| 150 | Nederlando | nl |
| 213 | Svislando | ch |
| 212 | Svedio | se |
| 84 | Islando | is |
| 161 | Nov-Zelando | nz |
| 14 | Aŭstralio | au |
| 100 | Kenjo | ke |
| 204 | Sud-Afriko | za |
| 99999 | Enreta | ol |

## Model Event — Atalho

- **Validations required**: `title`, `description`, `city`, `country_id`, `date_start`, `date_end`, `code`, e pelo menos `site` ou `email`
- `code` é gerado automaticamente pelo callback `set_code` (`SecureRandom.hex(3)`)
- `specolisto` default: `"Kunveno"`
- `format` aceito: `nil`, `"onsite"`, `"hybrid"`, `"online"`
- `time_zone` default: `"Etc/UTC"`
- Online events: `city = "Reta"`, `country_id = 99999`
- `after_save` callback `update_duration_tags` adiciona tag "Unutaga" ou "Plurtaga"
- `after_commit` agenda `SciigasUzantojnAntauEventoJob` (Sidekiq/SolidQueue)
- `default_scope` filtra `deleted: false`

## Workflow

### 1. Descobrir o container

```bash
docker ps --filter name=eventaservo-staging_backend --format '{{.Names}}'
```

### 2. Verificar estado atual

```bash
bin/rails runner "
  puts \"Total: #{Event.count}\"
  puts \"Past: #{Event.pasintaj.count}\"
  puts \"Future: #{Event.venontaj.count}\"
"
```

### 3. Executar seed script

Copiar script Ruby local para o container via SSH:

```bash
scp /tmp/seed.rb srv2:/tmp/seed.rb
ssh srv2 "docker cp /tmp/seed.rb eventaservo-staging_backend.<SUFIXO>:/tmp/seed.rb \
  && docker exec eventaservo-staging_backend.<SUFIXO> bin/rails runner /tmp/seed.rb"
```

### 4. Verificar resultado

```bash
bin/rails runner /tmp/check.rb
```

## Estrutura do Seed Script

O script deve conter:

1. **Array de países** com `id`, `cities[]` (cidades realistas em Esperanto)
2. **Array de títulos** em Esperanto (~20 variações)
3. **Array de descrições** em Esperanto (~20 variações)
4. **Geração de datas**:
   - Passados: entre `Date.new(2025, 12, 1)` e `Time.zone.now.beginning_of_week - 1.week`
   - Futuros: entre `Time.zone.tomorrow` e `(Time.zone.now + 2.months).end_of_day`
5. **Variedade**:
   - A cada N eventos: um multi-day, um online, um híbrido
   - Adicionar tags de categoria (`Tag.find(722_219_490)` = Kunveno/Evento, etc.)
   - Tags de duração são adicionadas automaticamente pelo model

### Exemplo mínimo de criação:

```ruby
Event.create!(
  title: "Esperanta konversacia rondo en Berlino",
  description: "Ni kunvenos por praktiki Esperanton.",
  city: "Berlino",
  country_id: 62,
  user_id: 998_628_195,
  date_start: Time.zone.now.next_week + 14.hours,
  date_end: Time.zone.now.next_week + 17.hours,
  site: "https://example.org"
)
```

### One-day vs Multi-day:

```ruby
# One-day (daterange within same day)
date_start: day + 14.hours
date_end: day + 17.hours

# Multi-day (spanning multiple days)
date_start: day + 10.hours
date_end: day + 3.days + 18.hours
```

### Online vs Presencial:

```ruby
# Online
Event.new(online: true, city: "Reta", country_id: 99_999, format: "online")

# Presencial
Event.new(city: "San-Paŭlo", country_id: 30)

# Híbrido (presencial + link)
Event.new(city: "Parizo", country_id: 58, format: "hybrid")
```

## Cuidados

- Sempre usar `Event.new` + `e.save` em vez de `Event.create!` para evitar que um erro quebre todo o lote
- Verificar `e.errors.full_messages` em caso de falha
- `url_or_email` validation: **sempre** fornecer `site` ou `email`
- A geolocalização via Google API pode falhar em staging — o rescue silencia o erro, então lat/lng podem ficar `nil`
- Os jobs de reminder (`SciigasUzantojnAntauEventoJob`) serão enfileirados automaticamente — normal
- Não criar tags manualmente — o callback `update_duration_tags` cuida de "Unutaga"/"Plurtaga"
- Se quiser adicionar tags de categoria manualmente: `e.tags << tag unless e.tags.include?(tag)`

## Exemplo de seed completo

Ver o arquivo em `/tmp/seed_events.rb` na máquina local (criado em 27/05/2026) ou no servidor `srv2:/tmp/seed_events.rb`.
