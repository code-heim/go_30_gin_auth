package main

import (
	"gin_blogs/controllers"
	"gin_blogs/middlewares"
	"gin_blogs/models"
	"log"

	"github.com/gin-contrib/sessions"
	"github.com/gin-contrib/sessions/memstore"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func main() {
	godotenv.Load()
	r := gin.Default()

	// Init session store
	store := memstore.NewStore([]byte("secret"))
	r.Use(sessions.Sessions("blogs", store))

	r.Use(gin.Logger())

	r.LoadHTMLGlob("templates/**/*")

	models.ConnectDatabase()
	models.DBMigrate()

	blogs := r.Group("/blogs", middlewares.AuthMiddleware())
	{
		blogs.GET("/", controllers.BlogsIndex)
		blogs.GET("/:id", controllers.BlogsShow)
	}

	r.GET("/users/signup", controllers.SignupPage)
	r.GET("/users/login", controllers.LoginPage)
	r.POST("/users/signup", controllers.Signup)
	r.POST("/users/login", controllers.Login)
	r.DELETE("/users/logout", controllers.Logout)

	log.Println("Server started!")
	r.Run() // Default Port 8080
}
