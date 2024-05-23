// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Bookstore {


    struct Book {
        uint bookId;
        string title;
        string author;
        bool isPremium;
        uint price; 
    }

    mapping(uint => Book) public books;

   
    uint public nextBookId;

   constructor() {
    books[1] = Book(1, "Free Book 1", "Author 1", false, 0);
    books[2] = Book(2, "Free Book 2", "Author 2", false, 0);
}
    function addBook(string memory _title, string memory _author, bool _isPremium, uint _price) public {
        require(msg.sender == tx.origin, "Only owner can add books");
        books[nextBookId] = Book(nextBookId, _title, _author, _isPremium, _price);
        nextBookId++;
    }

    function getBook(uint _bookId) public view returns (string memory title, string memory author) {
        Book memory book = books[_bookId];
        require(book.bookId > 0, "Book cannot be  found");

        if (!book.isPremium) {
            return (book.title, book.author);
        } else {
            revert("Premium plan is required");
        }
    }
}