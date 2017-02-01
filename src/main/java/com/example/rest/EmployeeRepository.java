package com.example.rest;

import com.example.domain.Employee;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource
public interface EmployeeRepository extends CrudRepository<Employee, Long> {

}