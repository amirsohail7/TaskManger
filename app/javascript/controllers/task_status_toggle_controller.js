import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task-status-toggle"
export default class extends Controller {
  toggleStatus() {
    const taskElement = this.element;
    const taskId = taskElement.dataset.taskId;

    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    fetch(`/tasks/${taskId}/toggle_status`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken
      }
    })
      .then(response => response.json())
      .then(data => {
        const bgColorClass = data.completed ? 'bg-green-200' : 'bg-gray-100';
        taskElement.classList.remove('bg-gray-100', 'bg-green-200');
        taskElement.classList.add(bgColorClass);
      });
  }
}
