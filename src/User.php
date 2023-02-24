<?php

namespace Mubasher\GithubWorkflows;

use InvalidArgumentException;

class User
{
    public int $age;
    public array $favorite_movies = [];
    public string $name;
    public $servername;
    public $username;
    public $password;

    /**
     * @param int $age
     * @param string $name
     * @param $servername
     * @param $username
     * @param $password
     */
    public function __construct(int $age, string $name, $servername = null, $username = null, $password = null)
    {
        $this->age = $age;
        $this->name = $name;
        $this->servername = $servername;
        $this->username = $username;
        $this->password = $password;
    }

    public function tellName(): string
    {
        return "My name is " . $this->name . ".";
    }

    public function tellAge(): string
    {
        return "I am " . $this->age . " years old.";
    }

    public function addFavoriteMovie(string $movie): bool
    {
        $this->favorite_movies[] = $movie;

        return true;
    }

    public function removeFavoriteMovie(string $movie): bool
    {
        if (!in_array($movie, $this->favorite_movies)) throw new InvalidArgumentException("Unknown movie: " . $movie);

        unset($this->favorite_movies[array_search($movie, $this->favorite_movies)]);

        return true;
    }

    public function connectToDB(): bool
    {
        // Create connection
        $conn = new \mysqli($this->servername, $this->username, $this->password);
        // Check connection
        if ($conn->connect_error) {
            return false;
        }
        return true;
    }
}