---
layout: page
title: "Сертификати"
nav_order: 9
icon: "fas fa-certificate"
description: "Професионални сертификати и потврде о стручном усавршавању"
---

# Сертификати и Потврде

Овде се налазе сертификати, потврде и дипломе које документују континуирано стручно усавршавање и професионални развој.

## Међународни сертификати

### Еразмус+ програм
- **[Португал 2019 - Acquiring of knowledge for school and life]({{ '/assets/certificates/sertifikat-1784_2019-10939.pdf' | relative_url }})**
  - Период: 20-27. октобар 2019.
  - Мобилност и размена знања

### Future 4 US - Еразмус+ пројекат
- **[Практична искуства - српски]({{ '/assets/certificates/F4US-Prakticna-iskustva-2-SRB.pdf' | relative_url }})**
- **[Practical experiences - English]({{ '/assets/certificates/F4US-Practical-experiences-2-ENG-2.pdf' | relative_url }})**
  - Период: 2018-2020
  - Радионице за младе

## Национални семинари и обуке

### Подршка ученицима
- **[Подршка ученицима са сметњама у развоју]({{ '/assets/certificates/19-01-2021 Podrška učenicima.pdf' | relative_url }})**
  - Датум: 19.01.2021.

### Етика и интегритет
- **[Етика и интегритет у образовању]({{ '/assets/certificates/Sertifikat Etika i integritet 09.09.2022. Olivera.pdf' | relative_url }})**
  - Датум: 09.09.2022.

### Заштита од дискриминације
- **[Чланови тима за заштиту од дискриминације]({{ '/assets/certificates/Clanovi-tima-za-zastitu-od-diskriminacije.pdf' | relative_url }})**

## БИГЗ вебинари и семинари

### 2021. година
- **[Вебинар март 2021]({{ '/assets/certificates/BIGZ _ potvrda_vebinar_mart 2021 Olivera.pdf' | relative_url }})**
- **[Наставни материјали у инклузивном одељењу]({{ '/assets/certificates/BIGZ _ potvrda_vebinar_Nastavni materijali u inkluzivnom odeljenju.pdf' | relative_url }})**
- **[Вебинар хемије]({{ '/assets/certificates/BIGZ _ potvrda_vebinar_hemije.pdf' | relative_url }})**
- **[Општа потврда о вебинару]({{ '/assets/certificates/Bigz potvrda o vebinaru.pdf' | relative_url }})**

### Додатни БИГЗ сертификати
- **[Потврда са именом]({{ '/assets/certificates/Bigz potvrda o vebinaru sa imenom.pdf' | relative_url }})**
- **[Лични сертификат]({{ '/assets/certificates/Olivera Amidžić.pdf' | relative_url }})**

## Стручна усавршавања 2022-2024

### 2024. година
- **[Сертификат 2024]({{ '/assets/certificates/sertifikat-924_2024-1218.pdf' | relative_url }})**
- **[Документ јул 2025]({{ '/assets/certificates/SKM_308e25072609430.pdf' | relative_url }})**

### 2022. година
- **[Стручно усавршавање 2022]({{ '/assets/certificates/sertifikat-3_2022-7859.pdf' | relative_url }})**
- **[Документ јул 2024]({{ '/assets/certificates/SKM_308e24070813240.pdf' | relative_url }})**

### 2021. година
- **[Семинар 2021]({{ '/assets/certificates/sertifikat-2021-5-79-2575.pdf' | relative_url }})**

## Додатни документи и потврде

### Разни сертификати
- **[Лични сертификат Оливера Амиџић]({{ '/assets/certificates/Olivera Amidžić, sertifikat.pdf' | relative_url }})**
- **[Потврда о учешћу]({{ '/assets/certificates/potvrda_Olivera_Amidzic.pdf' | relative_url }})**
- **[Општи документ]({{ '/assets/certificates/221.pdf' | relative_url }})**
- **[Скениран документ]({{ '/assets/certificates/CamScanner 09-02-2021 08.45.pdf' | relative_url }})**

### Службени документи
- **[Службени документ април 2022]({{ '/assets/certificates/SKM_308e22042514310.pdf' | relative_url }})**

## Динамички преглед сертификата

<div class="certificates-gallery" id="dynamic-certificates-gallery">
{% assign certificate_files = site.static_files | where_exp: "file", "file.path contains '/assets/certificates/'" %}
{% for file in certificate_files %}
  {% assign extension = file.extname | downcase %}
  {% if extension == '.pdf' or extension == '.png' or extension == '.jpg' or extension == '.jpeg' %}
    {% assign filename = file.basename %}
    
    <div class="certificate-item" onclick="openCertificate('{{ file.path | relative_url }}')">
      {% if extension == '.png' or extension == '.jpg' or extension == '.jpeg' %}
        <img src="{{ file.path | relative_url }}" alt="{{ filename }}" class="certificate-image" loading="lazy">
      {% else %}
        <div class="pdf-thumbnail-container">
          <canvas class="certificate-image pdf-canvas" data-pdf-url="{{ file.path | relative_url }}" id="canvas-{{ forloop.index }}"></canvas>
          <div class="pdf-fallback certificate-image" style="display: none;">
            <i class="fas fa-file-pdf"></i>
            <span>PDF</span>
          </div>
        </div>
      {% endif %}
      <p>{{ filename }}</p>
    </div>
  {% endif %}
{% endfor %}
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js"></script>
<script>
// Configure PDF.js worker
pdfjsLib.GlobalWorkerOptions.workerSrc = 'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js';

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

// Generate thumbnails for all PDF canvases
document.addEventListener('DOMContentLoaded', function() {
  const pdfCanvases = document.querySelectorAll('.pdf-canvas');
  pdfCanvases.forEach(canvas => {
    const pdfUrl = canvas.dataset.pdfUrl;
    if (pdfUrl) {
      generatePDFThumbnail(canvas, pdfUrl);
    }
  });
});
</script>

---

## О континуираном образовању

Континуирано стручно усавршавање је кључни део професионалног развоја сваког педагога. Кроз године, учествовала сам у бројним семинарима, радионицама и обукама које су проширили мoja знања у областима:

- **Инклузивно образовање** и рад са ученицима са посебним потребама
- **Етика и интегритет** у образовном раду
- **Модерне наставне методе** и приступи учењу
- **Међународна сарадња** кроз Еразмус+ програме
- **Заштита од дискриминације** у образовним институцијама
- **Каријерно вођење** и саветовање младих

Сваки од ових сертификата представља корак у професионалном развоју и потврду посвећености квалитетном образовању.

<style>
.certificates-gallery {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1.5rem;
  margin-top: 2rem;
}

.certificate-item {
  text-align: center;
  padding: 1rem;
  border: 1px solid var(--border-color, #e0e0e0);
  border-radius: 8px;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
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
  margin: 0;
  font-size: 0.9rem;
  color: var(--text-color, #333);
  font-weight: 500;
}



@media (max-width: 576px) {
  .certificates-gallery {
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 1rem;
  }
  
  .certificate-image {
    height: 120px;
  }
}
</style>