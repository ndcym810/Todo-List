const inputBox = document.getElementById("todo-input");
const listBody = document.getElementById("list-body");

// Add event listener for Enter key press
inputBox.addEventListener("keypress", function (event) {
  if (event.key === "Enter") {
    event.preventDefault();
    addTodo();
  }
});

function addTodo() {
  if (inputBox.value === "") {
    alert("Please enter a todo");
  } else {
    let li = document.createElement("li");

    // Create checkbox
    let checkbox = document.createElement("input");
    checkbox.type = "checkbox";
    checkbox.className = "todo-checkbox";
    li.appendChild(checkbox);

    // Add todo text
    let todoText = document.createElement("span");
    todoText.className = "todo-text";
    todoText.textContent = inputBox.value;
    li.appendChild(todoText);

    // Add delete button
    let span = document.createElement("span");
    span.className = "delete-btn";
    span.innerHTML = `\u00d7`;
    li.appendChild(span);

    // Add to list
    listBody.appendChild(li);
  }
  inputBox.value = "";
  saveData();
}

listBody.addEventListener(
  "click",
  (e) => {
    if (e.target.classList.contains("todo-checkbox")) {
      e.target.parentElement.classList.toggle("checked");
      saveData();
    } else if (e.target.classList.contains("delete-btn")) {
      e.target.parentElement.remove();
      saveData();
    }
  },
  false
);

function saveData() {
  localStorage.setItem("data", listBody.innerHTML);
}

function showTask() {
  listBody.innerHTML = localStorage.getItem("data");
}
showTask();
