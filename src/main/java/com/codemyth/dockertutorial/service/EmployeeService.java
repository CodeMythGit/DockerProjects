package com.codemyth.dockertutorial.service;


import com.codemyth.dockertutorial.model.Address;
import com.codemyth.dockertutorial.model.Employee;
import com.codemyth.dockertutorial.repository.AddressRepository;
import com.codemyth.dockertutorial.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private AddressRepository addressRepository;

    public Employee saveEmployee(Employee employee) {
        List<Address> addressList = addressRepository.saveAll(employee.getAddress());
        employee.setAddress(addressList);
        return employeeRepository.save(employee);
    }

    public List<Employee> getAllEmployees() {
        return employeeRepository.findAll();
    }
}
