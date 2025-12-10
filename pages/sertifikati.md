---
layout: page
title: "Сертификати"
nav_order: 9
icon: "fas fa-certificate"
description: "Професионални сертификати и потврде о стручном усавршавању"
---

# Сертификати и Потврде

Овде се налазе сертификати, потврде и дипломе које документују континуирано стручно усавршавање и професионални развој.

## Филтер по категоријама

<div class="filter-container" id="filter-container">
  <div class="filter-section">
    <button class="filter-btn active" data-filter="all">Сви сертификати</button>
    <button class="filter-btn clear-filters" onclick="clearAllFilters()">Очисти филтере</button>
  </div>
  <div class="tags-section" id="tags-section">
    <!-- Tags will be populated dynamically -->
  </div>
</div>

## Динамички преглед сертификата

<div class="certificates-gallery" id="dynamic-certificates-gallery">
  <!-- Certificates will be populated dynamically -->
</div>

<div class="no-results" id="no-results" style="display: none;">
  <p>Нема сертификата који одговарају изабраним филтерима.</p>
</div>

---

## О континуираном образовању

Континуирано стручно усавршавање је кључни део професионалног развоја сваког педагога. Кроз године, учествовала сам у бројним семинарима, радионицама и обукама које су проширили моја знања у областима:

- **Инклузивно образовање** и рад са ученицима са посебним потребама
- **Етика и интегритет** у образовном раду
- **Модерне наставне методе** и приступи учењу
- **Међународна сарадња** кроз Еразмус+ програме
- **Заштита од дискриминације** у образовним институцијама
- **Каријерно вођење** и саветовање младих

Сваки од ових сертификата представља корак у професионалном развоју и потврду посвећености квалитетном образовању.

<script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js"></script>
<script>
// Configure PDF.js worker
pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js';

let allCertificates = [];
let activeTags = new Set();

// Tag translations for display
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
  'documents': 'Документи',
  '2021': '2021',
  '2022': '2022',
  '2024': '2024',
  '2025': '2025'
};

function openCertificate(url) {
  window.open(url, '_blank');
}

async function generatePDFThumbnail(canvas, pdfUrl) {
  try {
    const loadingTask = pdfjsLib.getDocument(pdfUrl);
    const pdf = await loadingTask.promise;
    const page = await pdf.getPage(1);
    
    const scale = 0.8;
    const viewport = page.getViewport({ scale });
    
    canvas.width = viewport.width;
    canvas.height = viewport.height;
    
    const context = canvas.getContext('2d');
    const renderContext = {
      canvasContext: context,
      viewport: viewport
    };
    
    await page.render(renderContext).promise;
    canvas.style.display = 'block';
  } catch (error) {
    console.error('Error generating PDF thumbnail:', error);
    // Show fallback
    const fallback = canvas.parentElement.querySelector('.pdf-fallback');
    if (fallback) {
      canvas.style.display = 'none';
      fallback.style.display = 'flex';
    }
  }
}

function extractTagsFromPath(path) {
  const pathParts = path.split('/');
  const certificatesIndex = pathParts.indexOf('certificates');
  
  if (certificatesIndex === -1) return [];
  
  // Get all folder names after 'certificates' (excluding the filename)
  const tags = pathParts.slice(certificatesIndex + 1, -1);
  return tags;
}

function createCertificateElement(file) {
  const filename = file.name;
  const extension = file.extension.toLowerCase();
  const tags = extractTagsFromPath(file.path);
  
  const div = document.createElement('div');
  div.className = 'certificate-item';
  div.dataset.tags = JSON.stringify(tags);
  div.onclick = () => openCertificate(file.url);
  
  let imageElement = '';
  if (['.png', '.jpg', '.jpeg'].includes(extension)) {
    imageElement = `<img src="${file.url}" alt="${filename}" class="certificate-image" loading="lazy">`;
  } else {
    const canvasId = `canvas-${Math.random().toString(36).substr(2, 9)}`;
    imageElement = `
      <div class="pdf-thumbnail-container">
        <canvas class="certificate-image pdf-canvas" data-pdf-url="${file.url}" id="${canvasId}"></canvas>
        <div class="pdf-fallback certificate-image" style="display: none;">
          <i class="fas fa-file-pdf"></i>
          <span>PDF</span>
        </div>
      </div>
    `;
  }
  
  const tagsDisplay = tags.length > 0 ? 
    `<div class="certificate-tags">${tags.map(tag => `<span class="tag">${tagTranslations[tag] || tag}</span>`).join('')}</div>` : '';
  
  div.innerHTML = `
    ${imageElement}
    <p>${filename}</p>
    ${tagsDisplay}
  `;
  
  return div;
}

function getAllTags() {
  const tagSet = new Set();
  allCertificates.forEach(cert => {
    const tags = JSON.parse(cert.dataset.tags);
    tags.forEach(tag => tagSet.add(tag));
  });
  return Array.from(tagSet).sort();
}

function createTagHierarchy(tags) {
  const hierarchy = {};
  
  allCertificates.forEach(cert => {
    const certTags = JSON.parse(cert.dataset.tags);
    
    // Build hierarchical structure
    for (let i = 0; i < certTags.length; i++) {
      const currentPath = certTags.slice(0, i + 1);
      const currentTag = certTags[i];
      const parentPath = currentPath.slice(0, -1);
      
      if (!hierarchy[currentTag]) {
        hierarchy[currentTag] = {
          tag: currentTag,
          path: currentPath,
          parent: parentPath.length > 0 ? parentPath[parentPath.length - 1] : null,
          children: new Set(),
          level: i
        };
      }
      
      if (parentPath.length > 0) {
        const parentTag = parentPath[parentPath.length - 1];
        if (hierarchy[parentTag]) {
          hierarchy[parentTag].children.add(currentTag);
        }
      }
    }
  });
  
  return hierarchy;
}

function createTagButtons() {
  const tagsSection = document.getElementById('tags-section');
  const allTags = getAllTags();
  const hierarchy = createTagHierarchy(allTags);
  
  // Group tags by level
  const tagsByLevel = {};
  Object.values(hierarchy).forEach(tagInfo => {
    if (!tagsByLevel[tagInfo.level]) {
      tagsByLevel[tagInfo.level] = [];
    }
    tagsByLevel[tagInfo.level].push(tagInfo);
  });
  
  // Create sections for each level
  Object.keys(tagsByLevel).sort().forEach(level => {
    const levelDiv = document.createElement('div');
    levelDiv.className = 'tag-level';
    levelDiv.innerHTML = `<h4>Ниво ${parseInt(level) + 1}</h4>`;
    
    const tagsDiv = document.createElement('div');
    tagsDiv.className = 'tag-buttons';
    
    tagsByLevel[level]
      .sort((a, b) => (tagTranslations[a.tag] || a.tag).localeCompare(tagTranslations[b.tag] || b.tag))
      .forEach(tagInfo => {
        const button = document.createElement('button');
        button.className = 'tag-btn';
        button.dataset.tag = tagInfo.tag;
        button.dataset.level = level;
        button.textContent = `${tagTranslations[tagInfo.tag] || tagInfo.tag}`;
        
        if (tagInfo.parent) {
          button.textContent += ` (${tagTranslations[tagInfo.parent] || tagInfo.parent})`;
        }
        
        button.onclick = () => toggleTag(tagInfo.tag, button);
        tagsDiv.appendChild(button);
      });
    
    levelDiv.appendChild(tagsDiv);
    tagsSection.appendChild(levelDiv);
  });
}

function toggleTag(tag, button) {
  if (activeTags.has(tag)) {
    activeTags.delete(tag);
    button.classList.remove('active');
  } else {
    activeTags.add(tag);
    button.classList.add('active');
  }
  
  filterCertificates();
}

function clearAllFilters() {
  activeTags.clear();
  document.querySelectorAll('.tag-btn').forEach(btn => btn.classList.remove('active'));
  document.querySelector('.filter-btn[data-filter="all"]').classList.add('active');
  filterCertificates();
}

function filterCertificates() {
  const gallery = document.getElementById('dynamic-certificates-gallery');
  const noResults = document.getElementById('no-results');
  let visibleCount = 0;
  
  allCertificates.forEach(cert => {
    const certTags = JSON.parse(cert.dataset.tags);
    let shouldShow = false;
    
    if (activeTags.size === 0) {
      shouldShow = true;
    } else {
      // Show if certificate has any of the active tags
      shouldShow = Array.from(activeTags).some(activeTag => certTags.includes(activeTag));
    }
    
    if (shouldShow) {
      cert.style.display = 'block';
      visibleCount++;
    } else {
      cert.style.display = 'none';
    }
  });
  
  if (visibleCount === 0) {
    noResults.style.display = 'block';
    gallery.style.display = 'none';
  } else {
    noResults.style.display = 'none';
    gallery.style.display = 'grid';
  }
}

// Load certificates dynamically
function loadCertificates() {
  const gallery = document.getElementById('dynamic-certificates-gallery');
  
  // This would be populated by Jekyll in a real implementation
  // For now, we'll use a placeholder that will be replaced by Jekyll's liquid tags
  
  // Since we can't dynamically fetch files from Jekyll in pure JS,
  // we need to use Jekyll's static_files in the liquid template
  {% assign certificate_files = site.static_files | where_exp: "file", "file.path contains '/assets/certificates/'" %}
  const files = [
    {% for file in certificate_files -%}
    {% assign extension = file.extname | downcase -%}
    {% if extension == '.pdf' or extension == '.png' or extension == '.jpg' or extension == '.jpeg' -%}
    {
      name: "{{ file.basename }}",
      path: "{{ file.path }}",
      url: "{{ file.path | relative_url }}",
      extension: "{{ file.extname }}"
    }{% unless forloop.last %},{% endunless %}
    {% endif -%}
    {% endfor %}
  ];
  
  files.forEach(file => {
    const certElement = createCertificateElement(file);
    gallery.appendChild(certElement);
    allCertificates.push(certElement);
  });
  
  // Generate PDF thumbnails after elements are added
  setTimeout(() => {
    document.querySelectorAll('.pdf-canvas').forEach(canvas => {
      const pdfUrl = canvas.dataset.pdfUrl;
      if (pdfUrl) {
        generatePDFThumbnail(canvas, pdfUrl);
      }
    });
  }, 100);
  
  // Create tag buttons
  createTagButtons();
}

// Initialize when page loads
document.addEventListener('DOMContentLoaded', function() {
  loadCertificates();
});
</script>

<style>
.filter-container {
  margin-bottom: 2rem;
  padding: 1rem;
  background-color: var(--bg-color, #f8f9fa);
  border-radius: 8px;
  border: 1px solid var(--border-color, #e0e0e0);
}

.filter-section {
  margin-bottom: 1rem;
  display: flex;
  gap: 1rem;
  align-items: center;
}

.filter-btn, .tag-btn {
  padding: 0.5rem 1rem;
  border: 1px solid var(--border-color, #ddd);
  border-radius: 20px;
  background-color: white;
  color: var(--text-color, #333);
  cursor: pointer;
  transition: all 0.3s ease;
  font-size: 0.9rem;
}

.filter-btn:hover, .tag-btn:hover {
  background-color: var(--theme-color, #2e7d32);
  color: white;
  border-color: var(--theme-color, #2e7d32);
}

.filter-btn.active, .tag-btn.active {
  background-color: var(--theme-color, #2e7d32);
  color: white;
  border-color: var(--theme-color, #2e7d32);
}

.clear-filters {
  background-color: #dc3545 !important;
  border-color: #dc3545 !important;
  color: white !important;
}

.clear-filters:hover {
  background-color: #c82333 !important;
  border-color: #bd2130 !important;
}

.tag-level {
  margin-bottom: 1rem;
}

.tag-level h4 {
  margin: 0 0 0.5rem 0;
  color: var(--theme-color, #2e7d32);
  font-size: 1rem;
}

.tag-buttons {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.certificates-gallery {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
  margin-top: 2rem;
}

.certificate-item {
  text-align: center;
  padding: 1rem;
  border: 1px solid var(--border-color, #e0e0e0);
  border-radius: 8px;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  cursor: pointer;
}

.certificate-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(46, 125, 50, 0.15);
}

.certificate-image {
  width: 100%;
  height: 150px;
  object-fit: cover;
  border-radius: 4px;
  margin-bottom: 0.5rem;
}

.certificate-item canvas.certificate-image {
  border: 1px solid #ddd;
  background-color: #fff;
  display: none;
}

.pdf-thumbnail-container {
  position: relative;
  width: 100%;
  height: 150px;
}

.pdf-fallback {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background-color: #f5f5f5;
  border: 2px dashed #ccc;
  color: #666;
  font-size: 0.9rem;
}

.pdf-fallback i {
  font-size: 48px;
  color: #d32f2f;
  margin-bottom: 0.5rem;
}

.certificate-item p {
  margin: 0.5rem 0;
  font-size: 0.9rem;
  color: var(--text-color, #333);
  font-weight: 500;
}

.certificate-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.25rem;
  justify-content: center;
  margin-top: 0.5rem;
}

.tag {
  background-color: var(--theme-color, #2e7d32);
  color: white;
  padding: 0.2rem 0.5rem;
  border-radius: 12px;
  font-size: 0.7rem;
  font-weight: 500;
}

.no-results {
  text-align: center;
  padding: 2rem;
  color: var(--text-color, #666);
  font-style: italic;
}

@media (max-width: 768px) {
  .certificates-gallery {
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
  }
  
  .certificate-image {
    height: 120px;
  }
  
  .filter-section {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.5rem;
  }
  
  .tag-buttons {
    gap: 0.25rem;
  }
  
  .filter-btn, .tag-btn {
    padding: 0.4rem 0.8rem;
    font-size: 0.8rem;
  }
}

@media (max-width: 576px) {
  .certificates-gallery {
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  }
  
  .certificate-image {
    height: 100px;
  }
}
</style>