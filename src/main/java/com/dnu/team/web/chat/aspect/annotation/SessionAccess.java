package com.dnu.team.web.chat.aspect.annotation;

import java.lang.annotation.*;


@Target({ElementType.TYPE, ElementType.FIELD})
@Retention(value = RetentionPolicy.RUNTIME)
public @interface SessionAccess {

     String redirectUrl() default "auth";

}