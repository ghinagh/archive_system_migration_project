package com.startupstack.app.shared.wordindex;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "WORD")
public class WordEntity {

    @EmbeddedId
    private WordId id;
}
