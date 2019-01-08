function resizePhotoContainers(){
  const photoContainers = document.querySelectorAll(".photo-container")
  const photoContainer  = document.querySelector(".photo-container:not(.d-none)")
  if (photoContainer){
    const photoContainerWidth = photoContainer.offsetWidth
    photoContainers.forEach(photoContainer => photoContainer.style.height = `${photoContainerWidth}px`)
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const searchInput    = document.getElementById('kapp10-filter')
  const sexSelect      = document.getElementById('filterSexe')
  const categorySelect = document.getElementById('filterCategory')
  const raceDetailTabs = document.querySelectorAll('.race_detail_tab')
  
  filterPhotos()

  searchInput.addEventListener('keyup', () => filterPhotos())
  sexSelect.addEventListener('change', () => filterPhotos())
  if (categorySelect) categorySelect.addEventListener('change', () => filterPhotos())

  raceDetailTabs.forEach(raceDetailTab => {
    raceDetailTab.addEventListener('click', () => filterPhotos())
  })
})

window.addEventListener('resize', () => {
  resizePhotoContainers()
})

function filterPhotos(pageNumber = 1) {
  const searchInput           = document.getElementById('kapp10-filter')
  const sexSelect             = document.getElementById('filterSexe')
  const categorySelect        = document.getElementById('filterCategory')
  const raceTabSelected       = document.querySelector('.race_detail_tab:checked')
  const searchInputValue      = searchInput.value
  const sexSelectedValue      = sexSelect.value
  const categorySelectedValue = categorySelect.value
  const raceTabSelectedValue  = raceTabSelected.dataset.value
  const photosContainerRow    = document.querySelector('.photos-container .row')
  const numberPhotosByPage    = 48
  const paginationContainer   = document.querySelector('.pagination-container')
  const pageNumbersElements   = document.querySelector('.page-numbers')
  const pagePreviousBtn       = document.getElementById('page-previous')
  const pageNextBtn           = document.getElementById('page-next')

  let activePage, pageBtnElement

  const photosData = JSON.parse(document.getElementById('photos-data').dataset.photosData)

  let photoDataFiltered = photosData
  
  photoDataFiltered = photoDataFiltered.filter(data => {
    let photoToKeep = true
    
    // Filter on Race
    photoToKeep = photoToKeep && (data.race === raceTabSelectedValue)

    // Filter on Sex
    if (sexSelectedValue !== 'all') {
      photoToKeep = photoToKeep && (data.sex === sexSelectedValue)
    }

    // Filter on Category
    if (categorySelect && categorySelectedValue !== 'all') {
      photoToKeep = photoToKeep && (data.categ === categorySelectedValue)
    }

    // Filter on Search
    if (searchInputValue !== "") {
      if (Number.isInteger(Number.parseInt(searchInputValue))) {
        photoToKeep = photoToKeep && (data.bib === searchInputValue)
      } else {
        const matchValue = data.name.toLowerCase().match(searchInputValue.toLowerCase())
        photoToKeep = photoToKeep && (matchValue && matchValue[0])
      }
    }

    return photoToKeep
  })
  

  const numberOfPages = Math.ceil(photoDataFiltered.length / numberPhotosByPage)

  // Filter on the first page
  photoDataFiltered = photoDataFiltered.slice((pageNumber - 1) * numberPhotosByPage, pageNumber * numberPhotosByPage)

  photosContainerRow.innerHTML = ''
  photoDataFiltered.forEach(photoData => {
    let photoHoverTextElements = []

    if (photoData.bib !== '') {
      photoHoverTextElements.push(`#${photoData.bib}`)
    }

    if (photoData.name !== '') {
      photoHoverTextElements.push(photoData.name)
    }

    photoHoverTextElements.push(photoData.race)
    photoHoverTextElements.push(photoData.sex)
    photoHoverTextElements.push(photoData.categ)

    const photoHoverText = photoHoverTextElements.join(' - ')

    let photoHoverTextHTML = ''
    if (photoHoverText !== '') {
      photoHoverTextHTML = `<p>${photoHoverText}</p>`
    }

    const photoHTML = `<div class="col-6 col-sm-6 col-md-3 col-lg-2 photo-container">` +
        `<a href="${photoData.url}" target="_blank">` +
          `<div class="photo-front-hover-container">` +
            `<div class="photo-front" style="background-image: url('${photoData.url}'); background-color: black; background-repeat: no-repeat; background-size: contain; background-position: center;"></div>` +
            '<div class="photo-hover">' +
              photoHoverTextHTML +
              '<p><i class="fas fa-download"></i></p>' +
            '</div>'
          '</div>' +
          '</a>' +
      '</div>'
      photosContainerRow.insertAdjacentHTML('beforeend', photoHTML)
  })
  
  if (photoDataFiltered.length === 0) {
    photosContainerRow.innerHTML = '<div class="col-12 noResults">Pas de résultat</div>'
  }

  if (numberOfPages > 1) {
    let beginningNumberPage, endNumberPage

    if (pageNumber === 1) {
      beginningNumberPage = 1
    } else if (pageNumber === numberOfPages) {
      beginningNumberPage = pageNumber - 2
    } else {
      beginningNumberPage = pageNumber - 1
    }

    if (numberOfPages < beginningNumberPage + 2) {
      endNumberPage = numberOfPages
    } else {
      endNumberPage = beginningNumberPage + 2
    }

    pageNumbersElements.innerHTML = ''
    
    for (let i = beginningNumberPage; i <= endNumberPage; i++) {
      if (i === pageNumber) {
        activePage = 'active'
      } else {
        activePage = ''
      }
      
      pageNumbersElements.insertAdjacentHTML('beforeend', `<li id="page-${i}" data-page-number="${i}" class="page-item page-number ${activePage}">${i}</li>`)
      pageBtnElement = document.getElementById(`page-${i}`)
      pageBtnElement.addEventListener('click', event => filterPhotos(Number.parseInt(event.currentTarget.dataset.pageNumber)))
    }
    
    paginationContainer.classList.remove('d-none')

    if (pageNumber === 1) {
      pagePreviousBtn.classList.add('d-none')
    } else {
      pagePreviousBtn.addEventListener('click', event => filterPhotos(pageNumber - 1))
      pagePreviousBtn.classList.remove('d-none')
    }

    if (pageNumber === numberOfPages) {
      pageNextBtn.classList.add('d-none')
    } else {
      pageNextBtn.addEventListener('click', event => filterPhotos(pageNumber + 1))
      pageNextBtn.classList.remove('d-none')
    }
  } else {
    paginationContainer.classList.add('d-none')
  }

  resizePhotoContainers()
}