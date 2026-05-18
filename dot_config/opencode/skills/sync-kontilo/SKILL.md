---
name: sync-kontilo
description: "Use quando o usuário pedir para sincronizar/conciliar uma fatura de cartão de crédito em PDF com o Kontilo. Inclui remover senha do PDF, extrair texto, comparar lançamentos, identificar faltantes e cadastrar no Kontilo. Também ativa quando o usuário mencionar 'fatura', 'cartão', 'kontilo', 'PDF do cartão' ou 'sincronizar fatura'."
---

# Sync Kartão → Kontilo

Workflow para sincronizar uma fatura de cartão de crédito (PDF) com os registros no Kontilo.

## Pré-requisitos

- `qpdf` (para remover senha do PDF) — instalar via `brew install qpdf`
- `pdftotext` (do poppler, para extrair texto do PDF) — instalar via `brew install poppler`
- Ferramentas Kontilo (MCP tools)

## Workflow

### 1. Receber o PDF

O usuário fornece o caminho do PDF da fatura. Exemplo:
`/Users/shayani/Downloads/Fatura_VISA_100479873261_05-2026.pdf`

### 2. Remover senha (se necessário)

Se o PDF tiver senha, perguntar a senha ao usuário e usar `qpdf`:

```bash
qpdf --decrypt --password=SENHA "input.pdf" "output_sem_senha.pdf"
```

### 3. Extrair texto do PDF

```bash
pdftotext "arquivo_sem_senha.pdf" -
```

Analisar o texto extraído para identificar:
- Nome do titular
- Final do cartão
- Vencimento
- Fechamento
- Total da fatura
- Todos os lançamentos com data, estabelecimento, categoria e valor
- Lançamentos de múltiplos cartões (finais diferentes)

### 4. Encontrar a fatura correspondente no Kontilo

```bash
kontilo_listar_faturas(account_id=ID)
```

Usar `kontilo_listar_contas()` primeiro para descobrir o ID da conta (ex: VISA Infinity = 3).

Match por:
- Nome da conta (ex: "VISA Infinity")
- Mês/ano (ex: 05/2026)
- Data de fechamento (ex: 14/05/2026)
- Data de vencimento (ex: 21/05/2026)

### 5. Listar registros existentes no Kontilo

```bash
kontilo_listar_registros(credit_card_statement_id=ID)
```

Buscar todas as páginas (o resultado é paginado, 30 por página).

### 6. Comparar e identificar faltantes

Comparar cada lançamento do PDF com os registros do Kontilo. Estratégia de matching:

1. **Match por valor aproximado** (tolerância de R$ 0,05) + **contexto** (payee similar)
2. Muitos payees no Kontilo usam nomes normalizados diferentes do PDF:
   - `MP*MICHELLANCHES` → `Tapioca`
   - `RESTAURANTE CASA DO RA` → `Casa do Rapha`
   - `BEMAIS SUPERMERCADOS` → `BeMais` ou `Supermercado BeMais`
   - `POPEYES` → `Popeye`
   - `POSTO DE COMBUSTIVEIS` → `Posto de Gasolina`
   - `REDEPHARMA` → `RedePharma` ou `Drogaria`
   - `VIDRACARIA NORDEST` → `Vidraçaria Nordeste`
   - `papelaria` → `Lojinha`
3. Ignorar ajustes de centavos (valores negativos pequenos como -0,01, -0,02, -0,04)
4. Usar script Python para matching automatizado quando houver muitos itens

### 7. Perguntar categorias duvidosas

Para estabelecimentos não óbvios, perguntar ao usuário qual categoria usar.

Mapeamento de categorias comum (baseado no PDF):
| Categoria no PDF | Categoria no Kontilo | ID |
|---|---|---|
| ALIMENTAÇÃO | Alimentação / Restaurantes | 5 |
| ALIMENTAÇÃO (almoço) | Alimentação / Almoço | 6 |
| ALIMENTAÇÃO (lanches) | Alimentação / Lanches | 19 |
| ALIMENTAÇÃO (sushi) | Alimentação / Sushi | 61 |
| SUPERMERCADO | Supermercado | 1 |
| SAÚDE | Saúde / Drogaria | 9 |
| VEÍCULOS | Veículos / Combustível | 2 |
| VEÍCULOS (seguro) | Veículos / Seguro | 49 |
| DIVERSOS | Outros | 14 |
| HOBBY (pet shop) | Pets / Hamster | 68 |
| EDUCAÇÃO | Educação | 23 |
| LAZER | Lazer | 3 |
| VESTUÁRIO | Vestuário | 34 |
| MORADIA | Casa / Manutenção | 35 |
| BRINQUEDOS | Lazer / Brinquedos | 39 |

### 8. Criar registros faltantes

Usar `kontilo_criar_registro` para cada lançamento faltante:
- `account_id`: ID da conta (VISA Infinity = 3)
- `payee`: nome do estabelecimento (usar nome normalizado quando aplicável)
- `date`: data no formato YYYY-MM-DD (usar data dentro do período da fatura)
- `record_items`: `[{value, category_id}]` (valor SEMPRE POSITIVO, Kontilo aplica o sinal)

### 9. Verificar resultado

Confirmar que o saldo da fatura no Kontilo ficou próximo do total do PDF.

## Notas

- O campo `description` em `record_items` não aceita `null` — usar string vazia `""` se não tiver descrição.
- Para registros com data muito anterior ao fechamento da fatura, o Kontilo pode não associar à fatura correta. Usar uma data dentro do período de faturamento (entre fechamento anterior e fechamento atual).
- Paginação: `kontilo_listar_registros` retorna 30 por página. Sempre verificar `total_pages` e iterar se necessário.
