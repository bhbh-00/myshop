package com.bh.myshop.exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code = HttpStatus.NOT_FOUND, reason = "genFile not found")
public class GenFileNotFoundException  extends RuntimeException {
}
