---
name: organizar-drive
description: "Use quando o usuário pedir para organizar, arrumar, mover, limpar ou sincronizar arquivos no Google Drive, especialmente da pasta 'Documentos Obsidian'. Também ativa quando o usuário mencionar 'mover para canônica', 'reorganizar Drive', 'arrumar PDFs' ou 'limpar Obsidian'. Inclui identificar tipo do documento, extrair conteúdo com pdftotext e tesseract OCR, mapear para pasta canônica correspondente, renomear no padrão correto, remover duplicatas e renomear arquivos .tmp."
---

# Organizar Google Drive

Workflow para organizar arquivos do Google Drive, movendo de `Documentos Obsidian/Fernando/` (e subpastas) para suas pastas canônicas. **Nada fica no Obsidian** — tudo vai para pastas canônicas.

## Pré-requisitos

- `pdftotext` (do poppler) — `brew install poppler`
- `tesseract` (OCR para imagens) — `brew install tesseract tesseract-lang`
- Acesso de leitura/escrita ao Google Drive sincronizado localmente

## Pastas Canônicas

| Tipo de documento | Pasta destino | Padrão de nome |
|---|---|---|
| Nota fiscal de produto (DANFE, NFCE, DFE) | `Notas fiscais e garantias/` | `YYYY-MM-DD - Nome do Produto.ext` |
| Contrato de móveis/garantias | `Notas fiscais e garantias/` | `YYYY-MM-DD - Descrição.ext` |
| Manual de produto | `Notas fiscais e garantias/` | `Manual Produto - Página N.ext` |
| Contrato social, CNPJ, dados Kosmotek | `Kosmotek/Documentação/` | Manter original ou `YYYY-MM-DD - Descrição.pdf` |
| Financeiro Kosmotek (informes) | `Kosmotek/Contabilidade/` | Manter original |
| Veículos (Tracker) | `Shays/Veículos/Chevrolet Tracker/{Manutenções, Seguros}/` | `YYYY-MM-DD - Descrição.ext` |
| Veículos (Etios) | `Shays/Veículos/Toyota Etios/{IPVA, Seguros}/` | `YYYY-MM-DD - Descrição.ext` |
| IPVA, licenciamento, DETRAN | `Shays/Veículos/{Modelo}/` | `YYYY-MM-DD - Descrição.ext` |
| Apólice de seguro veicular | `Shays/Veículos/{Modelo}/Seguros/` | `YYYY-MM-DD - Apólice Seguradora - Modelo.pdf` |
| DUT/CRLV/ATPV (documentos veiculares) | `Shays/Veículos/{Modelo}/` | `YYYY-MM-DD - Descrição.ext` |
| Orçamento/oficina veicular | `Shays/Veículos/{Modelo}/` | `YYYY-MM-DD - Descrição.ext` |
| Imposto de Renda | `Shays/Imposto de renda/Ano base {ano}/` | `YYYY-MM-DD - Descrição.ext` |
| Informe de Rendimentos | `Shays/Imposto de renda/Ano base {ano}/` | `YYYY-MM-DD - Informe Rendimentos {Fonte}.pdf` |
| DARF IRPF | `Shays/Imposto de renda/Ano base {ano}/` | `YYYY-MM-DD - DARF IRPF {valor}.ext` |
| Despesas dedutíveis (escola, saúde) | `Shays/Imposto de renda/Ano base {ano}/` | `YYYY-MM-DD - Descrição.ext` |
| Cidadania Portuguesa | `Shays/Processo Cidadania Portuguesa/` | `YYYY-MM-DD - Descrição.pdf` |
| 123 Milhas / viagens | `Shays/Processo 123 Milhas/` | Manter nome |
| Imóveis (Real Bothanic) | `Shays/Imóveis/Real Bothanic/` | `YYYY-MM-DD - Nª Mensalidade Real Bothanic.pdf` |
| Aluguel (Orquídeas do Sul) | `Shays/Imóveis/Aluguel Orquídeas do Sul/` | Manter nome |
| Casa no Águia Dourada | `Shays/Imóveis/Casa no Águia Dourada/{subpasta}/` | Manter nome |
| Instalação elétrica (fotos) | `Shays/Imóveis/Casa no Águia Dourada/Instalação elétrica/` | `Descrição.jpg` |
| Visto EUA | `Coisas Fernando/Visto EUA 2024/` | `YYYY-MM-DD - Descrição.ext` |
| Cursos (Rascunho Studio) | `Desenho/` | `YYYY-MM-DD - Descrição.ext` |
| Contratos/recibos de curso | `Desenho/` | `YYYY-MM-DD - Descrição.ext` |
| Notas de desenvolvimento | `DEVEL/{subpasta}/` | Manter nome |
| Faturas de serviço (ex: Brisanet) | `Finanças/` | Perguntar ao usuário |
| Seguro de vida/saúde | Perguntar ao usuário | — |
| Fotos pessoais | `Shays/Fotos/` ou perguntar | — |
| Documentos pessoais (saúde) | Ficam em `Shays/Saúde/` no Obsidian ou mover | — |

## Identificação de Veículos por Placa

| Placa | Modelo |
|---|---|
| QSM9D03 | Chevrolet Tracker |
| QSK1H00 | Toyota Etios |

## Workflow

### 1. Listar arquivos a organizar

```bash
find "/Users/shayani/.../Documentos Obsidian/Fernando/" -maxdepth 1 -type f \( -iname "*.pdf" -o -iname "*.jpg" -o -iname "*.png" \) | sort
```

Perguntar ao usuário qual tema quer processar.

### 2. Extrair conteúdo

**Para PDFs:**
```bash
pdftotext "arquivo.pdf" -
```

**Para imagens (fotos, screenshots):**
```bash
tesseract "arquivo.jpg" - -l por
```

**Metadados úteis:**
- `pdfinfo "arquivo.pdf"` → CreationDate
- `mdls "arquivo.jpg"` → metadata macOS (data de criação, dimensões)
- `sips -g all "arquivo.jpg"` → make/model da câmera, dimensões

Buscar por:
- **Emitente:** Amazon, Mercado Livre, Samsung, Dell, Brazmotors, etc.
- **Data de emissão:** `DATA EMISSÃO`, `Data de emissão`
- **Produto/Serviço:** `DESCRIÇÃO DOS PRODUTOS / SERVIÇOS`
- **Placa/Veículo:** `PLACA`, `RENAVAM`
- **Valores:** `R$`, `Total`, `valor pago`
- **Favorecido (Pix):** `nome do favorecido` (identificar Heloísa = apagar)
- **SEFAZ:** identificar IPVA, ITCD, ICMS pelo valor

### 3. Mapear para pasta canônica

| Tipo identificado | Destino |
|---|---|
| DANFE/NFCE com produto | `Notas fiscais e garantias/` |
| Contrato de móveis/garantias | `Notas fiscais e garantias/` |
| Documento Kosmotek | `Kosmotek/Documentação/` ou `Contabilidade/` |
| Documento veicular | `Shays/Veículos/{Modelo}/` |
| Apólice de seguro veicular | `Shays/Veículos/{Modelo}/Seguros/` |
| IPVA/DETRAN/licenciamento | `Shays/Veículos/{Modelo}/` |
| Imposto de Renda (DARF, informes, recibos) | `Shays/Imposto de renda/Ano base {ano}/` |
| Cidadania Portuguesa | `Shays/Processo Cidadania Portuguesa/` |
| 123 Milhas | `Shays/Processo 123 Milhas/` |
| Real Bothanic (mensalidades) | `Shays/Imóveis/Real Bothanic/` |
| Aluguel Orquídeas do Sul | `Shays/Imóveis/Aluguel Orquídeas do Sul/` |
| Casa no Águia Dourada | `Shays/Imóveis/Casa no Águia Dourada/` |
| Visto EUA | `Coisas Fernando/Visto EUA 2024/` |
| Curso de desenho (Rascunho Studio) | `Desenho/` |
| Notas de desenvolvimento | `DEVEL/` |
| Fatura Brisanet | Perguntar (sugerir `Finanças/`) |
| Seguro (Mongeral Aegon) | Perguntar ao usuário |
| Pix para Heloísa | Apagar (comprovantes pessoais) |
| Arquivos vazios/ilegíveis | Apagar |
| Foto pessoal | Perguntar destino |
| Screenshot de compra online | `Notas fiscais e garantias/` |

### 4. Renomear e mover

```bash
mv "origem/arquivo.pdf" "destino/YYYY-MM-DD - Nome Descritivo.pdf"
```

Sempre usar o padrão `YYYY-MM-DD - Descrição.ext` com:
- Data de emissão do documento (ou data da compra, ou data de criação do PDF)
- Nome descritivo do produto/serviço
- Manter acentos e caracteres especiais

### 5. Arquivos `.tmp`

Arquivos com extensão `.tmp.tmp` ou `.md.tmp.tmp` são temporários do Obsidian. Devem ser renomeados removendo a extensão `.tmp.tmp`:

```bash
for f in $(find "..." -name "*.tmp.tmp"); do
  mv "$f" "${f%.tmp.tmp}"
done
```

### 6. Imagens sem conteúdo identificável

Para imagens onde o OCR não retorna texto legível:
1. Verificar metadados com `sips -g all` (câmera, data, modelo)
2. Se for foto de câmera (Galaxy, iPhone) → foto pessoal
3. Perguntar ao usuário o destino
4. Se for manual/produto → `Notas fiscais e garantias/`

### 7. Limpeza final

- Remover pastas vazias do Obsidian com `rmdir`
- Verificar se não restaram arquivos com `find`

## Mapeamento de Produtos Conhecidos

| ASIN / Chave | Produto | Data | Valor |
|---|---|---|---|
| B09LYZP1LG | Teclado Logitech MX Keys Mini | 14/09/2023 | R$ 611,99 |
| — | Notebook Samsung Galaxy Book3 360 | 13/03/2024 | R$ 4.999,00 |
| UN43DU8000GXZD | TV Samsung 43" Crystal | 13/11/2024 | R$ 1.629,00 |
| LP320 | Liquidificador Black & Decker | 24/11/2024 | R$ 269,90 |
| Dell G15 5530 | Notebook Dell G15 5530 | 10/12/2024 | R$ 5.285,23 |
| Beelink SERS Pro | Mini PC Beelink Ryzen 7 5825U | 16/08/2025 | R$ 2.969,00 |

## Notas

- O Google Drive sincronizado localmente mantém a estrutura de pastas — `mv` funciona como moveria no Finder.
- Arquivos `.tmp.tmp` são temporários do Obsidian — SEMPRE renomear removendo `.tmp.tmp`, nunca apagar.
- Nomes de arquivo com acentos e espaços devem ser preservados.
- Para identificar o ano base do IRPF: ano calendário = ano da declaração - 1.
- Comprovantes Pix para Heloísa Patrício de Melo (CPF 701.633.794-40) devem ser apagados.
- O padrão de nome na canônica `Notas fiscais e garantias/` é `YYYY-MM-DD - Nome do Produto.ext`.
- Tesseract OCR funciona melhor com `-l por` para português.
