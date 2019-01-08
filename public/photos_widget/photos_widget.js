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
  resizePhotoContainers()

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
  const photosDataElements    = document.querySelectorAll('.photo-data')
  const photosContainer       = document.querySelectorAll('.photo-container')
  const noResultsDiv          = document.querySelector('.noResults')
  const numberPhotosByPage    = 48
  const paginationContainer   = document.querySelector('.pagination-container')
  const pageNumbersElements   = document.querySelector('.page-numbers')
  const pagePreviousBtn       = document.getElementById('page-previous')
  const pageNextBtn           = document.getElementById('page-next')

  let activePage, pageBtnElement

  const photosData = Array.from(photosDataElements).map(element => {
    const data = {
      id:    element.dataset.photoId,
      race:  element.dataset.race,
      sex:   element.dataset.sex,
      categ: element.dataset.categ,
      name:  element.dataset.name,
      bib:   element.dataset.bib,
    }
    return data
  })

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
  
  photosContainer.forEach(photoContainer => {
    if (photoDataFiltered.map(data => data.id).includes(photoContainer.dataset.photoId)) {
      photoContainer.classList.remove('d-none')
      noResultsDiv.classList.add('d-none')
    } else {
      photoContainer.classList.add('d-none')
    }
  })
  
  if (photoDataFiltered.length === 0) noResultsDiv.classList.remove('d-none')

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
}