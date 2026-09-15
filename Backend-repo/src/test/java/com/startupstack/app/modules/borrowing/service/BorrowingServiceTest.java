package com.startupstack.app.modules.borrowing.service;

import com.startupstack.app.modules.borrowing.dto.BorrowingResponse;
import com.startupstack.app.modules.borrowing.dto.ReturnRequest;
import com.startupstack.app.modules.borrowing.entity.BorrowingEntity;
import com.startupstack.app.modules.borrowing.entity.BorrowingId;
import com.startupstack.app.modules.borrowing.mapper.BorrowingMapper;
import com.startupstack.app.modules.borrowing.repository.BorrowingRepository;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.persons.repository.PersonRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class BorrowingServiceTest {

    @Mock
    private BorrowingRepository borrowingRepository;
    @Mock
    private PersonRepository personRepository;
    @Mock
    private CatalogueRepository catalogueRepository;
    @Mock
    private BorrowingMapper borrowingMapper;
    @InjectMocks
    private BorrowingService borrowingService;

    @Test
    void returnBorrowing_setsReturnDate() {
        BorrowingEntity entity = new BorrowingEntity();
        entity.setIarNo("IAR001");
        entity.setSerial(1.0);
        entity.setBorrowingType(1.0);
        entity.setReturnDate(null);

        LocalDateTime returnDate = LocalDateTime.of(2026, 6, 26, 12, 0);
        ReturnRequest request = new ReturnRequest();
        request.setReturnDate(returnDate);

        BorrowingResponse response = new BorrowingResponse();
        response.setReturnDate(returnDate);

        when(borrowingRepository.findById(any(BorrowingId.class))).thenReturn(Optional.of(entity));
        when(borrowingRepository.save(entity)).thenReturn(entity);
        when(borrowingMapper.toResponse(entity)).thenReturn(response);

        BorrowingResponse result = borrowingService.returnBorrowing("IAR001", 1.0, 1.0, request);

        assertEquals(returnDate, entity.getReturnDate());
        verify(borrowingRepository).save(entity);
    }

    @Test
    void returnBorrowing_nonExistent_throwsResourceNotFound() {
        when(borrowingRepository.findById(any(BorrowingId.class))).thenReturn(Optional.empty());

        ReturnRequest request = new ReturnRequest();
        request.setReturnDate(LocalDateTime.now());

        assertThrows(ResourceNotFoundException.class,
                () -> borrowingService.returnBorrowing("NONE", 1.0, 1.0, request));
    }

    @Test
    void findById_nonExistent_throwsResourceNotFound() {
        when(borrowingRepository.findById(any(BorrowingId.class))).thenReturn(Optional.empty());

        assertThrows(ResourceNotFoundException.class,
                () -> borrowingService.findById("NONE", 1.0, 1.0));
    }

    @Test
    void delete_nonExistent_throwsResourceNotFound() {
        when(borrowingRepository.existsById(any(BorrowingId.class))).thenReturn(false);

        assertThrows(ResourceNotFoundException.class,
                () -> borrowingService.delete("NONE", 1.0, 1.0));
    }
}
