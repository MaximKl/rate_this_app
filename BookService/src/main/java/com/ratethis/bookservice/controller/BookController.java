package com.ratethis.bookservice.controller;

import com.ratethis.bookservice.entity.Country;
import com.ratethis.bookservice.entity.book.*;
import com.ratethis.bookservice.entity.user.User;
import com.ratethis.bookservice.entity.user.UserBook;
import com.ratethis.bookservice.service.BookService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

@Controller
@RequestMapping("/books")
@Slf4j
public class BookController {

    @Autowired
    private BookService bookService;


    @GetMapping("")
    private String getBook(@RequestParam(value = "bname", required = false) String bookName, Model userModel) {
        List<Book> allBooks = bookService.getAllBooks();
        List<Book> booksToReturn = new ArrayList<>();
        if (bookName != null) {
            if (!bookName.isBlank()) {
                List<String> words = Arrays.stream(bookName.split(" ")).toList();
                for (Book b : allBooks) {
                    List<String> bNameWords = Arrays.stream(b.getName().split(" ")).toList();
                    for (String s : words) {
                        if (bNameWords.stream().anyMatch(w -> s.equalsIgnoreCase(w)) && booksToReturn.stream().noneMatch(book -> book.getName().equalsIgnoreCase(b.getName())))
                            booksToReturn.add(b);
                    }
                }
                if (booksToReturn.isEmpty()) {
                    userModel.addAttribute("mes", "Пошук за назвою - '" + bookName + "' не дав результатів");
                    userModel.addAttribute("searched", bookName);
                    userModel.addAttribute("allBooks", booksToReturn);
                    userModel.addAttribute("user", new User());
                    log.info("Bad filtered books page");
                    return "books-page";
                }
            }
        }

        if (booksToReturn.isEmpty()) {
            userModel.addAttribute("allBooks", allBooks.stream().sorted(Comparator.comparing(Book::getName)).toList());
        } else {
            userModel.addAttribute("allBooks", booksToReturn.stream().sorted(Comparator.comparing(Book::getName)).toList());
            userModel.addAttribute("mes", "Результати пошуку за назвою - " + bookName);
            userModel.addAttribute("searched", bookName);
        }
        userModel.addAttribute("user", new User());
        log.info("Getting all books page");
        return "books-page";
    }


    @PostMapping
    private @ResponseBody String removeBook(@RequestParam(value = "bookId") String bookId) {
        if (bookId != null) {
            if (!bookId.isBlank()) {
                bookService.removeBook(Integer.parseInt(bookId));
                return "OK";
            }
        }
        return "BAD";
    }

    @GetMapping("/add")
    private String addBook(Model bookModel) {
        bookModel.addAttribute("book", new Book());
        bookModel.addAttribute("allCategories", bookService.getAllCategories().stream().sorted(Comparator.comparing(BookCategory::getName)).toList());
        bookModel.addAttribute("allAuthors", bookService.getAllAuthors().stream().sorted(Comparator.comparing(BookAuthor::getSurname)).toList());
        bookModel.addAttribute("allCountries", bookService.getAllCountries().stream().sorted(Comparator.comparing(Country::getName)).toList());
        bookModel.addAttribute("allBooks", bookService.getAllBooks());
        log.info("Getting add-book page");
        return "add-book";
    }


    @GetMapping("/{id}")
    private String getBook(@PathVariable("id") int id, Model userModel, HttpServletRequest request,
                           @RequestParam(value = "comM", required = false) String commonMark,
                           @RequestParam(value = "txtM", required = false) String textMark,
                           @RequestParam(value = "stM", required = false) String storyMark,
                           @RequestParam(value = "toChange", required = false) String toChange) {

        System.out.println(request.getRequestURL());
        Book searchedBook = bookService.getBookById(id);
        User user = null;
        boolean isUserScoreBook = false;
        boolean alwaysTrue = false;
        boolean isOperation = false;
        int ugId = 0;
        if (searchedBook.getId() == 0)
            return "redirect:/profile";

        List<Integer> numbers = new ArrayList<>();
        for (int i = 0; i < 101; i++)
            numbers.add(i);

        List<Cookie> cookies = Arrays.stream(request.getCookies()).toList();
        if (cookies.stream().anyMatch(c -> c.getName().equals("user_id"))) {
            if (searchedBook.getComments().stream().anyMatch(c -> c.getUser().getId() == Integer.parseInt(cookies.stream().filter(cc -> cc.getName().equals("user_id")).findFirst().get().getValue())))
                alwaysTrue = true;
            user = bookService.getUser(Integer.parseInt(cookies.stream().filter(c -> c.getName().equals("user_id")).findFirst().get().getValue()));
            if (user.getBooks().stream().anyMatch(g -> g.getBook().getId() == id)) {
                isUserScoreBook = true;
            }
        }

        if (toChange != null) {
            if (toChange.equals("1"))
                isUserScoreBook = false;
        }

        if (commonMark != null && textMark != null && storyMark != null) {
            if (!commonMark.isBlank() && !textMark.isBlank() && !storyMark.isBlank() && !isUserScoreBook) {
                try {
                    int comM = Integer.parseInt(commonMark);
                    int txtM = Integer.parseInt(textMark);
                    int stM = Integer.parseInt(storyMark);
                    if (comM >= 0 && comM <= 100 && txtM >= 0 && txtM <= 100 && stM >= 0 && stM <= 100) {
                        if (user.getBooks().stream().anyMatch(g -> g.getBook().getId() == id)) {
                            ugId = user.getBooks().stream().filter(userBook -> userBook.getBook().getId() == id).findFirst().get().getId();
                            UserBook receivedUb = bookService.getUseBookById(ugId);
                            receivedUb.setCommonMark(comM);
                            receivedUb.setArtMark(txtM);
                            receivedUb.setStoryMark(stM);
                            bookService.saveUserBook(receivedUb);
                        } else {
                            user.getBooks().add(bookService.saveUserBook(new UserBook(0, comM, txtM, stM, user, searchedBook)));
                            bookService.saveUser(user);
                        }
                        isOperation = true;
                    } else {
                        userModel.addAttribute("wrong", "Надано невірні значення");
                    }
                } catch (Exception e) {
                    userModel.addAttribute("wrong", "Надано невірні значення");
                }
            } else {
                userModel.addAttribute("wrong", "Надано невірні значення");
            }
        }

        List<BookComment> userComments = new ArrayList<>();
        if (alwaysTrue) {
            userComments = user.getBookComments().stream().filter(bc -> bc.getBook().getId() == id).toList();
            userModel.addAttribute("thisBookComment", userComments);
        }

        userModel.addAttribute("isCommented", !userComments.isEmpty());
        userModel.addAttribute("isScored", isUserScoreBook);
        userModel.addAttribute("numbers", numbers);
        userModel.addAttribute("book", searchedBook);
        userModel.addAttribute("bookComments", searchedBook.getComments().stream().sorted(Comparator.comparingInt(BookComment::getRating).reversed()).toList());
        userModel.addAttribute("user", new User());
        log.info("Getting the page of a book - " + searchedBook.getName());
        if (isOperation)
            return "redirect:/books/" + id;
        return "book-page";
    }


    @PostMapping("/{id}")
    private @ResponseBody String sentInfoComment(@PathVariable("id") int id,
                                                 @RequestParam(value = "comment", required = false) String comment,
                                                 @RequestParam(value = "uid", required = false) String userId,
                                                 @RequestParam(value = "comId", required = false) String commentId,
                                                 @RequestParam(value = "like", required = false) String isLiked,
                                                 @RequestParam(value = "deleteMyComment", required = false) String isDeleteCom) {
        if (userId != null && commentId != null && isLiked != null) {
            if (!commentId.isBlank() && !userId.isBlank() && !isLiked.isBlank()) {
                BookComment bc = bookService.getCommentById(Integer.parseInt(commentId));
                User user = bookService.getUser(Integer.parseInt(userId));
                if (bc.getId() != 0 && user.getId() != 0) {
                    if (user.getBookReactions().stream().noneMatch(r -> r.getComment().getId() == bc.getId())) {
                        if (isLiked.equals("true")) {
                            bookService.saveReaction(new BookReaction(0, true, false, user, bc));
                        } else if (isLiked.equals("false")) {
                            bookService.saveReaction(new BookReaction(0, false, true, user, bc));
                        }
                        return "OK";
                    } else {
                        BookReaction previousReaction = user.getBookReactions().stream().filter(reaction -> reaction.getComment().getId() == bc.getId()).findFirst().get();
                        if (previousReaction.isLike() && isLiked.equals("true")) {
                            previousReaction.setLike(false);
                            bookService.saveReaction(previousReaction);
                        } else if (previousReaction.isLike() && isLiked.equals("false")) {
                            previousReaction.setLike(false);
                            previousReaction.setDislike(true);
                            bookService.saveReaction(previousReaction);
                            return "change";
                        } else if (previousReaction.isDislike() && isLiked.equals("false")) {
                            previousReaction.setDislike(false);
                            bookService.saveReaction(previousReaction);
                        } else if (previousReaction.isDislike() && isLiked.equals("true")) {
                            previousReaction.setDislike(false);
                            previousReaction.setLike(true);
                            bookService.saveReaction(previousReaction);
                            return "change";
                        } else if (!previousReaction.isDislike() && !previousReaction.isLike() && isLiked.equals("true")) {
                            previousReaction.setLike(true);
                            bookService.saveReaction(previousReaction);
                            return "OK";
                        } else if (!previousReaction.isDislike() && !previousReaction.isLike() && isLiked.equals("false")) {
                            previousReaction.setDislike(true);
                            bookService.saveReaction(previousReaction);
                            return "OK";
                        }
                        return "removed";
                    }
                }
            }
        }

        if (comment != null && userId != null) {
            if (!comment.isBlank() && !userId.isBlank()) {
                Book searchedBook = bookService.getBookById(id);
                if (searchedBook.getId() == 0)
                    return "BAD";
                User user = bookService.getUser(Integer.parseInt(userId));
                if (user.getId() != 0) {
                    if (user.getBookComments().stream().noneMatch(g -> g.getBook().getId() == searchedBook.getId())) {
                        bookService.saveComment(new BookComment(0, 0, 0, 0, comment, user, searchedBook, new ArrayList<>()));
                        return "OK";
                    } else {
                        return "alreadyCommented";
                    }
                }
            }
        }

        if (isDeleteCom != null && commentId != null) {
            if (isDeleteCom.equals("true") && !commentId.isBlank()) {
                BookComment bc = bookService.getCommentById(Integer.parseInt(commentId));
                if (!bc.getReactions().isEmpty()) {
                    List<BookReaction> bReact = bc.getReactions();
                    bReact.forEach(reaction -> {
                        reaction.setComment(null);
                        reaction.setUser(null);
                        bookService.saveReaction(reaction);
                        bookService.removeReaction(reaction.getId());
                    });
                }
                bookService.removeComment(Integer.parseInt(commentId));
                return "OK";
            }
        }
        return "BAD";
    }


    @PostMapping("/add")
    private RedirectView postBook(@ModelAttribute("book") Book book, @RequestParam("auths") String authors, @RequestParam("cats") String cats) {
        List<Book> allBooks = bookService.getAllBooks();
        int existedId = 0;
        if (book.getName() != null) {
            if (!book.getName().isBlank()) {
                if (allBooks.stream().anyMatch(f -> f.getName().equalsIgnoreCase(book.getName())))
                    existedId = allBooks.stream().filter(b -> b.getName().equalsIgnoreCase(book.getName())).map(Book::getId).findFirst().get();
            }
        }

        List<BookAuthor> authorsToReturn = new ArrayList<>();
        List<BookCategory> categoriesToReturn = new ArrayList<>();
        if (authors != null) {
            if (!authors.isBlank()) {
                List<String> listAuthors = Arrays.stream(authors.split(";")).map(d -> d.substring(0, d.length())).toList();
                List<BookAuthor> allAuthors = bookService.getAllAuthors();
                for (String s : listAuthors) {
                    if (!s.isBlank()) {
                        List<String> nameSurname = new ArrayList<>(Arrays.stream(s.split(" ")).toList());
                        if (nameSurname.size() == 1)
                            nameSurname.add(" ");
                        if (allAuthors.stream().noneMatch(a -> a.getName().equalsIgnoreCase(nameSurname.get(0)) && a.getSurname().equalsIgnoreCase(nameSurname.get(1)))) {
                            authorsToReturn.add(bookService.saveAuthor(new BookAuthor(0, nameSurname.get(0), nameSurname.get(1), new ArrayList<>())));

                        } else if (allAuthors.stream().anyMatch(a -> a.getName().equalsIgnoreCase(nameSurname.get(0)) && a.getSurname().equalsIgnoreCase(nameSurname.get(1))))
                            authorsToReturn.add(allAuthors.stream().filter(a -> a.getName().equalsIgnoreCase(nameSurname.get(0)) && a.getSurname().equalsIgnoreCase(nameSurname.get(1))).findFirst().get());
                    }
                }
            }
        }

        if (cats != null) {
            if (!cats.isBlank()) {
                List<String> categories = Arrays.stream(cats.split(";")).map(c -> c.substring(0, c.length())).toList();
                List<BookCategory> allCategories = bookService.getAllCategories();
                for (String s : categories) {
                    if (allCategories.stream().noneMatch(c -> c.getName().equalsIgnoreCase(s)) && !s.isBlank())
                        categoriesToReturn.add(bookService.saveCategory(new BookCategory(0, s, new ArrayList<>())));
                    else if (allCategories.stream().anyMatch(c -> c.getName().equalsIgnoreCase(s)))
                        categoriesToReturn.add(allCategories.stream().filter(c -> c.getName().equalsIgnoreCase(s)).findFirst().get());
                }
            }
        }


        if (existedId > 0) {
            Book existingBook = bookService.getBookById(existedId);
            book.setArtMark(existingBook.getArtMark());
            book.setCommonMark(existingBook.getCommonMark());
            book.setStoryMark(existingBook.getStoryMark());
        }

        book.setId(existedId);
        book.getAuthors().addAll(authorsToReturn);
        book.getCategories().addAll(categoriesToReturn);

        Book savedBook = bookService.saveBook(book);

        log.info("Book with id - " + savedBook.getId() + " was successfully saved");
        return new RedirectView("http://localhost:9191/books");
    }
}
