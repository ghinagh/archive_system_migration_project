package com.startupstack.app.modules.news.entity;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@EqualsAndHashCode
public class NewsWordEntityId implements Serializable {

    private String wrdAppNo;
    private String wrdWord;
}
