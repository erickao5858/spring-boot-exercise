package com.hcl.controller;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.hcl.model.Book;
import com.hcl.service.BookService;

@Controller
public class BookController {
	@Autowired
	BookService bookService;

	@GetMapping("/")
	public String viewBooks() {
		return "Library";
	}
	
	@GetMapping("/books")
	public @ResponseBody Collection<Book> getBooks() {
		return bookService.getAllBooks();
	}

	@GetMapping("/addBook")
	public String addBookView(Model model) {
		model.addAttribute("book", new Book());
		return "AddBook";
	}

	@PostMapping("/addBook")
	public RedirectView addBook(@ModelAttribute("book") Book book, RedirectAttributes redirectAttributes) {
		final RedirectView redirectView = new RedirectView("/addBook", true);
		Book savedBook = bookService.addBook(book);
		redirectAttributes.addFlashAttribute("savedBook", savedBook);
		redirectAttributes.addFlashAttribute("addBookSuccess", true);
		return redirectView;
	}

	@GetMapping("/editBook/{bookId}")
	public String editBookView(@PathVariable("bookId") int bookId, Model model) {
		model.addAttribute("book", bookService.getBookById(bookId));
		return "EditBook";
	}

	@PutMapping("/editBook/{bookId}")
	public RedirectView editBook(@ModelAttribute("book") Book book, RedirectAttributes redirectAttributes) {
		final RedirectView redirectView = new RedirectView("/editBook/" + book.getBookId(), true);
		Book savedBook = bookService.updateBook(book);
		redirectAttributes.addFlashAttribute("savedBook", savedBook);
		redirectAttributes.addFlashAttribute("editBookSuccess", true);
		return redirectView;
	}

	@DeleteMapping("/deleteBook/{bookId}")
	public RedirectView deleteBook(@PathVariable("bookId") int bookId) {
		bookService.deleteBook(bookId);
		final RedirectView redirectView = new RedirectView("/", true);
		return redirectView;
	}
}