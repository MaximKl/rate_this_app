package com.ratethis.bookservice.service;

import com.ratethis.bookservice.entity.Country;
import com.ratethis.bookservice.entity.book.*;
import com.ratethis.bookservice.entity.user.User;
import com.ratethis.bookservice.entity.user.UserBook;
import com.ratethis.bookservice.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BookService {
    @Autowired
    private BookRepository bookRepository;
    @Autowired
    private CountryRepository countryRepository;
    @Autowired
    private BookCategoryRepository bookCategoryRepository;

    @Autowired
    private BookCommentRepository bookCommentRepository;
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BookReactionRepository bookReactionRepository;

    @Autowired
    private UserBookRepository userBookRepository;

    @Autowired
    private BookAuthorRepository bookAuthorRepository;

    public Book saveBook(Book book) {
        return bookRepository.save(book);
    }

    public BookComment saveComment(BookComment comment){
        return bookCommentRepository.save(comment);
    }

    public BookReaction saveReaction(BookReaction reaction){
        return bookReactionRepository.save(reaction);
    }

    public Book getBookById(int id){
        return bookRepository.findById(id).orElseGet(Book::new);
    }

    public UserBook getUseBookById(int id){
        return userBookRepository.findById(id).orElseGet(UserBook::new);
    }

    public BookComment getCommentById(int id){
        return bookCommentRepository.findById(id).orElseGet(BookComment::new);
    }

    public User getUser(int id){
        return userRepository.findById(id).orElseGet(User::new);
    }

    public List<Book> getAllBooks(){
        return bookRepository.findAll();
    }
    public List<Country> getAllCountries(){
        return countryRepository.findAll();
    }

    public List<BookCategory> getAllCategories(){
        return bookCategoryRepository.findAll();
    }

    public List<BookAuthor> getAllAuthors(){
        return bookAuthorRepository.findAll();
    }

    public BookCategory saveCategory(BookCategory bookCategory){
        return bookCategoryRepository.save(bookCategory);
    }

    public BookAuthor saveAuthor(BookAuthor bookAuthor){
        return bookAuthorRepository.save(bookAuthor);
    }

    public UserBook saveUserBook(UserBook userBook){
        return userBookRepository.save(userBook);
    }

    public User saveUser(User user){
        return userRepository.save(user);
    }

    public void removeComment(int comId){
        bookCommentRepository.deleteById(comId);

    }

    public void removeReaction(int react){
        bookReactionRepository.deleteById(react);

    }

    @Transactional
    public void removeBook(int bookId){
        bookRepository.remove(bookId);

    }
}
