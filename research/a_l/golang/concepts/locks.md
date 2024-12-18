# **[Lock and RLock in Golang](https://medium.com/@asgrr/lock-and-rlock-in-golang-74ca6ce95783)

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

![l](https://miro.medium.com/v2/resize:fit:720/format:webp/0*RkXw3FANW4D3nX1a.png)

In Go (Golang), a lock is a synchronization mechanism provided by the sync package, specifically the Mutex type. A lock is used to control access to a shared resource to ensure that only one goroutine can access it at a time. This helps prevent race conditions where multiple goroutines might try to modify the shared resource simultaneously, leading to unpredictable behavior.

In Go, the sync package provides two types of locks: RLock (read lock) and Lock (write lock).

## Write Lock (Lock)

The Lock provides exclusive access to a shared resource, allowing only one goroutine to modify it at a time. It ensures that no other goroutines can read or write while the write lock is held, ensuring consistency and preventing conflicts.

## Real-life Example: Ticket Reservation System

Consider a real-world scenario of a ticket reservation system, where multiple users can try to reserve seats simultaneously. Without proper synchronization, conflicts can arise, leading to incorrect booking or double booking. Using a lock can help maintain the integrity of the reservation system.

```go
package main

import (
 "fmt"
 "sync"
)

type TicketReservation struct {
 availableSeats int
 mu             sync.Mutex
}

func (tr *TicketReservation) ReserveSeats(seats int) bool {
 tr.mu.Lock()
 defer tr.mu.Unlock()

 if tr.availableSeats >= seats {
  fmt.Println("Processing reservation for", seats, "seats...")
  tr.availableSeats -= seats
  return true
 }

 return false
}

func (tr *TicketReservation) GetAvailableSeats() int {
 tr.mu.Lock()
 defer tr.mu.Unlock()
 return tr.availableSeats
}

func main() {
 reservation := TicketReservation{availableSeats: 11}
 var wg sync.WaitGroup

 // Multiple users trying to reserve seats concurrently
 for i := 0; i < 5; i++ {
  wg.Add(1)
  go func(users int) {
   defer wg.Done()
   seats := 2
   if reservation.ReserveSeats(seats) {
    fmt.Printf("User %d successfully reserved %d seats.\n", users, seats)
   } else {
    fmt.Printf("User %d failed to reserve seats. Available seats: %d.\n", users, reservation.GetAvailableSeats())
   }
  }(i + 1)
 }

 wg.Wait()

 fmt.Println("Remaining available seats:", reservation.GetAvailableSeats())
}
```

output

```bash
Processing reservation for 2 seats...
User 5 successfully reserved 2 seats.
Processing reservation for 2 seats...
User 1 successfully reserved 2 seats.
Processing reservation for 2 seats...
User 2 successfully reserved 2 seats.
Processing reservation for 2 seats...
User 3 successfully reserved 2 seats.
Processing reservation for 2 seats...
User 4 successfully reserved 2 seats.
Remaining available seats: 1
```

In this example:

The TicketReservation struct contains an availableSeats field and a sync.Mutex (mu) to protect access to the critical sections.

The ReserveSeats method uses the lock to ensure that only one user can reserve seats at a time.

Multiple users (goroutines) concurrently attempt to reserve seats, and the lock prevents conflicts, ensuring that the reservation system’s state is consistent.

## Read Lock (RLock)

The RLock allows multiple goroutines to read a shared resource simultaneously. It ensures that concurrent readers don't interfere with each other and provides a level of concurrency.

### Real-life Example: Online Article System

Consider a real-world scenario where an online article system allows multiple users to read articles simultaneously, but only one user at a time can submit or edit an article.

```go
package main

import (
 "fmt"
 "sync"
 "time"
)

type Article struct {
 Title   string
 Content string
}

type ArticleStore struct {
 articles map[string]Article
 rwMutex  sync.RWMutex
}

func (as *ArticleStore) ReadArticle(title string) (Article, bool) {
 as.rwMutex.RLock()
 defer as.rwMutex.RUnlock()

 article, exists := as.articles[title]
 return article, exists
}

func (as *ArticleStore) WriteArticle(title, content string) {
 as.rwMutex.Lock()
 defer as.rwMutex.Unlock()

 // Simulate processing time for writing/updating an article
 time.Sleep(time.Millisecond * 100)

 as.articles[title] = Article{Title: title, Content: content}
 fmt.Printf("Article '%s' updated.\n", title)
}

func main() {
 articleSystem := ArticleStore{
  articles: make(map[string]Article),
 }

 // Concurrent readers
 for i := 0; i < 3; i++ {
  go func(userNum int) {
   title := "Introduction to Go"
   article, exists := articleSystem.ReadArticle(title)
   if exists {
    fmt.Printf("User %d is reading '%s': %s\n", userNum, title, article.Content)
   } else {
    fmt.Printf("User %d couldn't find article '%s'.\n", userNum, title)
   }
  }(i + 1)
 }

 // Exclusive writer
 time.Sleep(50 * time.Millisecond) // Give readers a head start
 go func() {
  title := "Introduction to Go"
  newContent := "This is an updated introduction to Go programming."
  articleSystem.WriteArticle(title, newContent)
 }()

 time.Sleep(500 * time.Millisecond) // Allow time for goroutines to finish

 // Simulating more readers after the update
 for i := 3; i < 6; i++ {
  go func(userNum int) {
   title := "Introduction to Go"
   article, exists := articleSystem.ReadArticle(title)
   if exists {
    fmt.Printf("User %d is reading '%s': %s\n", userNum, title, article.Content)
   } else {
    fmt.Printf("User %d couldn't find article '%s'.\n", userNum, title)
   }
  }(i + 1)
 }

 time.Sleep(500 * time.Millisecond) // Allow time for additional readers

 // Display final state of the article
 finalArticle, exists := articleSystem.ReadArticle("Introduction to Go")
 if exists {
  fmt.Printf("Final state of the article: %s\n", finalArticle.Content)
 } else {
  fmt.Println("Article 'Introduction to Go' not found.")
 }
}
```

output

```bash
User 3 couldn't find article 'Introduction to Go'.
User 1 couldn't find article 'Introduction to Go'.
User 2 couldn't find article 'Introduction to Go'.
Article 'Introduction to Go' updated.
User 6 is reading 'Introduction to Go': This is an updated introduction to Go programming.
User 4 is reading 'Introduction to Go': This is an updated introduction to Go programming.
User 5 is reading 'Introduction to Go': This is an updated introduction to Go programming.
Final state of the article: This is an updated introduction to Go programming.
```

In this example:

The ArticleStore struct represents a store of articles with an RWMutex (rwMutex) to control access.

The ReadArticle method uses RLock to allow multiple users to read articles simultaneously.

The WriteArticle method uses Lock to ensure exclusive access during article updates.

Concurrent readers and a single writer are simulated to showcase the benefits of RWMutex in a scenario where multiple readers are allowed concurrently, and writes are exclusive.

## Conclusion

In Go, Lock and RLock are synchronization mechanisms provided by the sync package to control access to shared resources in a concurrent environment.

Lock ensures exclusive access, suitable for scenarios where only one goroutine should modify the shared resource at a time.

RLock is beneficial when multiple goroutines can safely read the shared resource concurrently but exclusive access is needed during write operations.
