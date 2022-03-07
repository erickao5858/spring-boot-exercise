package com.hcl.service;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hcl.model.Book;
import com.hcl.repository.BookRepository;

@Service
public class BookService {
	@Autowired
	BookRepository booksRepository;

	public List<Book> getAllBooks() {
		List<Book> books = new ArrayList<Book>();
		booksRepository.findAll().forEach(book -> books.add(book));
		return books;
	}

	public Book getBookById(int id) {
		return booksRepository.findById(id).get();
	}

	public Book addBook(Book book) {
		booksRepository.save(book);
		return book;
	}

	public void deleteBook(int id) {
		booksRepository.deleteById(id);
	}

	public Book updateBook(Book book) {
		booksRepository.save(book);
		return book;
	}
}