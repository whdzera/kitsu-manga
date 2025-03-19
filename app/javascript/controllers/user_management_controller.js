import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["table", "search", "filter", "loadMore"]
  
  connect() {
    console.log("User management controller connected")
  }
  
  search() {
    this.filterTable()
  }
  
  filterRole() {
    this.filterTable()
  }
  
  filterTable() {
    const searchText = this.searchTarget.value.toLowerCase()
    const roleFilter = this.filterTarget.value.toLowerCase()
    
    this.tableTarget.querySelectorAll("tbody tr").forEach(row => {
      const username = row.cells[0].textContent.toLowerCase()
      const email = row.cells[1].textContent.toLowerCase()
      const role = row.cells[2].textContent.toLowerCase()
      
      const matchesSearch = username.includes(searchText) || email.includes(searchText)
      const matchesRole = !roleFilter || role.includes(roleFilter)
      
      row.style.display = (matchesSearch && matchesRole) ? '' : 'none'
    })
  }
  
  loadMore(event) {
    const btn = this.loadMoreTarget
    const currentPage = parseInt(btn.dataset.page)
    const nextPage = currentPage + 1
    
    fetch(`${btn.dataset.path}?page=${nextPage}&format=json`)
      .then(response => response.json())
      .then(data => {
        if (data.users?.length > 0) {
          const template = document.createElement('template')
          const currentUserId = parseInt(btn.dataset.currentUserId)
          
          data.users.forEach(user => {
            template.innerHTML = this.createUserRowHtml(user, currentUserId)
            this.tableTarget.querySelector('tbody').appendChild(template.content.firstElementChild)
          })
          
          // Update page number
          btn.dataset.page = nextPage
          
          // Hide button if all users loaded
          if (nextPage * 10 >= parseInt(btn.dataset.total)) {
            btn.style.display = 'none'
          }
        }
      })
      .catch(error => console.error('Error loading users:', error))
  }
  
  createUserRowHtml(user, currentUserId) {
    const date = new Date(user.created_at)
    const formattedDate = date.toLocaleDateString('en-US', { 
      month: 'short', 
      day: 'numeric', 
      year: 'numeric' 
    })
    
    const deleteOrCurrentTag = user.id !== currentUserId
      ? `<form action="/admin/users/${user.id}" method="post" style="display: inline-block;">
          <input type="hidden" name="authenticity_token" value="${document.querySelector('meta[name="csrf-token"]')?.getAttribute('content')}">
          <input type="hidden" name="_method" value="delete">
          <button type="submit" class="button is-small is-danger is-outlined" data-turbo="false" 
                 data-confirm="Are you sure you want to delete this user?">
            <i class="fas fa-trash"></i>
          </button>
         </form>`
      : `<span class="tag is-info is-light">Current</span>`
    
    return `
      <tr>
        <td>${user.username}</td>
        <td>${user.email}</td>
        <td>${user.role.charAt(0).toUpperCase() + user.role.slice(1)}</td>
        <td>${formattedDate}</td>
        <td class="has-text-centered">
          <div class="buttons is-flex">
            <a href="/admin/users/${user.id}/edit" class="button is-small bg-transparent">
              <i class="fas fa-edit"></i>
            </a>
            ${deleteOrCurrentTag}
          </div>
        </td>
      </tr>
    `
  }
}