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
    public $dbname;

    /**
     * @param int $age
     * @param string $name
     * @param $servername
     * @param $username
     * @param $password
     */
    public function __construct(int $age, string $name, $servername = null, $username = null, $password = null, $dbname = null)
    {
        $this->age = $age;
        $this->name = $name;
        $this->servername = $servername;
        $this->username = $username;
        $this->password = $password;
        $this->dbname = $dbname;
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
        $conn = new \mysqli($this->servername, $this->username, $this->password, $this->dbname);
        // Check connection
        if ($conn->connect_error) {
            return false;
        }
        return true;
    }

    public function insertData(): bool
    {
        // Create connection
        $conn = new \mysqli($this->servername, $this->username, $this->password, $this->dbname);
        // Check connection
        if ($conn->connect_error) {
            return false;
        }
        $sql = "INSERT INTO tblactivityfeeds (ActivitySubject, ActivityType, ActivityDetails, CreatedDate, CreatedByUsername, CreatedByUserId, AuditFileNumber)
                VALUES ('muabsher', 'feed', 'dummy details', NOW(), 'mubasher', 1, 1)";

        if ($conn->query($sql) !== TRUE) {
            return false;
        }
        $conn->close();
        return true;
    }
}