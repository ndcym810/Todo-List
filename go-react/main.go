package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/joho/godotenv"
)

type Todo struct {
	ID        int    `json:"id"`
	Completed bool   `json:"completed"`
	Body      string `json:"body"`
}

var todos = []Todo{}

func main() {
	mux := http.NewServeMux()
	err := godotenv.Load(".env")
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	PORT := os.Getenv("PORT")

	mux.HandleFunc("GET /api/todos", handleRoot)
	mux.HandleFunc("POST /api/todos", addTodo)
	mux.HandleFunc("PATCH /api/todos/{id}", updateTodoStatus)
	mux.HandleFunc("DELETE /api/todos/{id}", deleteTodo)

	fmt.Println("Server listening to :8000")
	http.ListenAndServe(":" + PORT, mux)
}

func handleRoot(w http.ResponseWriter, r *http.Request){
	j, err := json.Marshal(todos)
	if err != nil {
		http.Error(
			w, err.Error(), http.StatusInternalServerError,
		)
		return
	}

	w.WriteHeader(http.StatusAccepted)
	w.Write(j)
}

func addTodo(w http.ResponseWriter, r *http.Request){
	todo := Todo{}

	err := json.NewDecoder(r.Body).Decode(&todo)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest,)
		return
	}

	
	if todo.Body == "" {
		http.Error(w, "Todo body is required", http.StatusBadRequest)
		return
	} 

	todo.ID = len(todos) + 1
	todos = append(todos, todo)

	w.WriteHeader(http.StatusCreated)
	j, err:= json.Marshal(todo)
	if err != nil {
		http.Error(
			w, err.Error(), http.StatusInternalServerError,
		)
		return
	}
	w.Write(j)
}

func updateTodoStatus(w http.ResponseWriter, r *http.Request){
	id := r.PathValue("id")

	for i, todo := range todos {
		if fmt.Sprint(todo.ID) == id {
			todos[i].Completed = !todos[i].Completed
			w.WriteHeader(http.StatusOK)
			w.Write([]byte("todo has been updated"))
			return
		}
	}

	w.WriteHeader(http.StatusNotFound)
}

func deleteTodo(w http.ResponseWriter, r *http.Request){
	id := r.PathValue("id")

	for i, todo := range todos {
		if fmt.Sprint(todo.ID) == id {
			todos = append(todos[:i], todos[i+1:]... )
			w.WriteHeader(http.StatusOK)
			w.Write([]byte("todo has been deleted"))
			return
		}
	}

	w.WriteHeader(http.StatusNotFound)

}