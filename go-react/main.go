package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/joho/godotenv"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type Todo struct {
	ID        primitive.ObjectID    `json:"_id,omitempty" bson:"_id,omitempty"`
	Completed bool   `json:"completed"`
	Body      string `json:"body"`
}

var collection *mongo.Collection

func main() {
	err := godotenv.Load(".env")
	if err != nil {
		log.Fatal("Error loading .env file")
	}
	
	MONGODB_URI := os.Getenv("MONGODB_URI")
	clientOptions := options.Client().ApplyURI(MONGODB_URI)
	client, err := mongo.Connect(context.Background(), clientOptions)
	
	if err != nil {
		log.Fatal(err)
	}

	defer client.Disconnect(context.Background())
	
	err = client.Ping(context.Background(), nil)
	if err != nil {
		log.Fatal(err)
	}
	
	fmt.Println("Connected to MONGODB ATLAS")
	
	collection = client.Database("todo_list").Collection("todos")
	
	mux := http.NewServeMux()
	mux.HandleFunc("GET /api/todos", getTodos)
	mux.HandleFunc("POST /api/todos", createTodo)
	mux.HandleFunc("PATCH /api/todos/{id}", updateTodoStatus)
	mux.HandleFunc("DELETE /api/todos/{id}", deleteTodo)
	
	PORT := os.Getenv("PORT")
	if PORT == "" {
		PORT = "8000"
	}
	log.Fatal(http.ListenAndServe(":" + PORT, mux))
}

func getTodos(w http.ResponseWriter, r *http.Request){
	var todos []Todo

	cursor, err := collection.Find(context.Background(), bson.M{})

	if err != nil {
		http.Error(
			w, err.Error(), http.StatusInternalServerError,
		)
		return
	}

	defer cursor.Close(context.Background())

	for cursor.Next(context.Background()){
		var todo Todo
		if err := cursor.Decode(&todo); err != nil {
			http.Error(
				w, err.Error(), http.StatusInternalServerError,
			)
			return
		}
		todos = append(todos, todo)
	}

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

func createTodo(w http.ResponseWriter, r *http.Request){
	todo := new(Todo)

	err := json.NewDecoder(r.Body).Decode(&todo)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest,)
		return
	}

	if todo.Body == "" {
		http.Error(w, "Todo body is required", http.StatusBadRequest)
		return
	} 

	insertResult, err := collection.InsertOne(context.Background(), todo)
	if err != nil {
		http.Error(
			w, err.Error(), http.StatusInternalServerError,
		)
		return
	}
	todo.ID = insertResult.InsertedID.(primitive.ObjectID)

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
	objectID, err := primitive.ObjectIDFromHex(id)
	if err != nil {
		http.Error(
			w, err.Error(), http.StatusBadRequest,
		)
		return
	}

	filter := bson.M{"_id":objectID}
	update := bson.M{"$set":bson.M{"completed":true}}

	_, err = collection.UpdateOne(context.Background(), filter, update)
	if err != nil {
		http.Error(
			w, err.Error(), http.StatusInternalServerError,
		)
		return
	}

	w.WriteHeader(http.StatusOK)
	w.Write([]byte("todo has been updated"))

}

func deleteTodo(w http.ResponseWriter, r *http.Request){
	id := r.PathValue("id")

	objectID, err := primitive.ObjectIDFromHex(id)
	if err != nil {
		http.Error(
			w, err.Error(), http.StatusBadRequest,
		)
		return
	}

	filter := bson.M{"_id":objectID}

	_, err = collection.DeleteOne(context.Background(), filter)
	if err != nil {
		http.Error(
			w, err.Error(), http.StatusInternalServerError,
		)
		return
	}

	w.WriteHeader(http.StatusOK)
	w.Write([]byte("todo has been deleted"))

}