CREATE DATABASE LibraryDB1;
USE LibraryDB1;

 -- Author Table
CREATE TABLE Author (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);
INSERT INTO Author (AuthorID,Name) VALUES
(1,'J.K. Rowling'),
(2,'George R.R. Martin'),
(3,'Agatha Christie'),
(4,'Dan Brown');

select *from Author;

-- Category Table
CREATE TABLE Category (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);
INSERT INTO Category (CategoryID,CategoryName) VALUES
(1,'Fiction'),
(2,'Mystery'),
(3,'Science Fiction'),
(4,'History');
select* from Category;

-- Book Table
CREATE TABLE Book (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);
INSERT INTO Book (Title, CategoryID) VALUES
('Harry Potter and the Sorcerer''s Stone', 1),
('A Game of Thrones', 1),
('Murder on the Orient Express', 2),
('The Da Vinci Code', 2),
('Dune', 3),
('Sapiens: A Brief History of Humankind', 4);
SELECT * FROM Book;
-- Book_Author Table (Many-to-Many Relationship)
CREATE TABLE Book_Author (
    BookID INT,
    AuthorID INT,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID),
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID)
);
INSERT INTO Book_Author (BookID, AuthorID) VALUES
(1, 1),      -- Harry Potter - J.K. Rowling
(2, 2),      -- Game of Thrones - George R.R. Martin
(3, 3),      -- Murder on the Orient Express - Agatha Christie
(4, 4),      -- The Da Vinci Code - Dan Brown
(5, 2),     -- Dune - George R.R. Martin (for example)
(6, 1);      -- Sapiens - J.K. Rowling (for example)

select* from Book_Author;

-- Member Table
CREATE TABLE Member (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL
);
INSERT INTO Member (Name, Email) VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com'),
('Charlie Brown', 'charlie@example.com');
SELECT * FROM Member;

-- Loan Table
CREATE TABLE Loan (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    LoanDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Book(BookID),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);
INSERT INTO Loan (BookID, MemberID, LoanDate, ReturnDate) VALUES
(1, 1, '2025-08-01', '2025-08-15'),
(2, 2, '2025-08-02', NULL);
select *from loan;
-- join all the table data

SELECT 
    b.BookID,
    b.Title AS BookTitle,
    c.CategoryName,
    a.AuthorID,
    a.Name AS AuthorName,
    m.MemberID,
    m.Name AS MemberName,
    l.LoanID,
    l.LoanDate,
    l.ReturnDate
FROM Book b
JOIN Category c 
    ON b.CategoryID = c.CategoryID
JOIN Book_Author ba 
    ON b.BookID = ba.BookID
JOIN Author a 
    ON ba.AuthorID = a.AuthorID
LEFT JOIN Loan l 
    ON b.BookID = l.BookID
LEFT JOIN Member m 
    ON l.MemberID = m.MemberID
ORDER BY b.BookID, l.LoanDate;


