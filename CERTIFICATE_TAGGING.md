# Certificate Tagging System

This document explains the hierarchical certificate tagging system implemented for the certificates page.

## Overview

The certificate tagging system organizes certificates into a hierarchical folder structure where each folder name becomes a tag. This allows for sophisticated filtering based on categories, subcategories, and specific criteria.

## Folder Structure

The certificates are organized in the following hierarchy:

```
/assets/certificates/
├── international/
│   └── erasmus/                    # Erasmus+ program certificates
├── national/
│   ├── support-students/           # Student support training
│   ├── ethics/                     # Ethics and integrity training
│   └── discrimination-protection/  # Discrimination protection training
├── publishers/
│   └── bigz/
│       └── webinars/              # BIGZ publisher webinars
├── professional-development/
│   ├── 2021/                      # Professional development from 2021
│   ├── 2022/                      # Professional development from 2022
│   ├── 2024/                      # Professional development from 2024
│   └── 2025/                      # Professional development from 2025
├── languages/
│   └── english/                   # English language certificates
└── general/
    └── documents/                 # General documents and certificates
```

## How Tagging Works

### Basic Principle
Each folder name in the path becomes a tag. For a certificate located at:
```
/assets/certificates/languages/english/certificate.pdf
```

The certificate gets two tags:
- `languages` (broader category)
- `english` (more specific)

### Hierarchical Specificity
Tags follow a hierarchy where deeper folders are more specific:

1. **General to Specific**: `publishers` → `bigz` → `webinars`
2. **Category to Detail**: `professional-development` → `2024`
3. **Broad to Narrow**: `national` → `ethics`

### Examples

| Certificate Path | Tags | Serbian Translation |
|-----------------|------|-------------------|
| `/certificates/international/erasmus/cert.pdf` | `international`, `erasmus` | Међународни, Еразмус+ |
| `/certificates/publishers/bigz/webinars/cert.pdf` | `publishers`, `bigz`, `webinars` | Издавачи, БИГЗ, Вебинари |
| `/certificates/professional-development/2024/cert.pdf` | `professional-development`, `2024` | Стручно усавршавање, 2024 |

## Filtering Features

### Single Tag Filtering
Users can filter by any single tag:
- Select "Међународни" to see all international certificates
- Select "Еразмус+" to see only Erasmus+ certificates (more specific)
- Select "2024" to see all 2024 certificates across all categories

### Multiple Tag Filtering
Users can combine tags for precise filtering:
- Select "Национални" + "Етика" to find national ethics training
- Select "БИГЗ" + "Вебинари" to find BIGZ webinars specifically

### Hierarchical Navigation
- Broader tags show more results (e.g., "Издавачи" shows all publisher certificates)
- Specific tags show fewer, more targeted results (e.g., "Вебинари" shows only webinars)

## Tag Translations

The system includes Serbian translations for all tags:

```javascript
const tagTranslations = {
  'international': 'Међународни',
  'erasmus': 'Еразмус+',
  'national': 'Национални',
  'support-students': 'Подршка ученицима',
  'ethics': 'Етика',
  'discrimination-protection': 'Заштита од дискриминације',
  'publishers': 'Издавачи',
  'bigz': 'БИГЗ',
  'webinars': 'Вебинари',
  'professional-development': 'Стручно усавршавање',
  'languages': 'Језици',
  'english': 'Енглески',
  'general': 'Општи',
  'documents': 'Документи'
};
```

## Implementation Details

### Frontend JavaScript
- Extracts tags from certificate file paths automatically
- Creates filter buttons organized by hierarchy levels
- Implements real-time filtering without page reload
- Shows/hides certificates based on selected tags

### Jekyll Integration
- Uses Jekyll's `site.static_files` to discover certificate files
- Maintains compatibility with existing Jekyll build process
- Generates dynamic content while preserving static site benefits

## Adding New Certificates

To add a new certificate:

1. **Choose appropriate folder** based on content/category
2. **Create new folders** if needed for new categories
3. **Add translation** for any new folder names in the tag translations
4. **File will be automatically discovered** and tagged by the system

### Example: Adding Language Certificates
For a German language certificate:
1. Create folder: `/assets/certificates/languages/german/`
2. Add certificate file to that folder
3. Add translation: `'german': 'Немачки'`
4. Certificate will automatically get tags: `languages`, `german`

## Benefits

1. **Intuitive Organization**: Folder structure reflects logical categorization
2. **Flexible Filtering**: Multiple ways to find specific certificates  
3. **Scalable**: Easy to add new categories without code changes
4. **Multilingual**: Serbian translations for user-friendly interface
5. **Hierarchical**: Supports both broad and specific searches
6. **Maintainable**: Git-friendly structure with minimal code changes needed

## Technical Notes

- The system scans all files in `/assets/certificates/` recursively
- Only files with extensions `.pdf`, `.png`, `.jpg`, `.jpeg` are processed
- PDF thumbnails are generated automatically using PDF.js
- Tag buttons are organized by hierarchy level for better UX
- All filtering happens client-side for fast response