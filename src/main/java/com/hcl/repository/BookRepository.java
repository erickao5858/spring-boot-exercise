package com.hcl.repository;

import org.springframework.data.repository.CrudRepository;

import com.hcl.model.Book;

public interface BookRepository extends CrudRepository<Book, Integer> {
}