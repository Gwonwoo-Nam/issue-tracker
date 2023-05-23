package com.issuetracker.domain;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Table("milestone")
public class Milestone {
    @Id
    private Integer id;
    private String name;
    private String description;
    @Column("completed_at")
    private LocalDateTime completedAt;
    private boolean opened;
    private boolean deleted;

    public static Milestone createAutoIncrementedMilestone(String name, String description, LocalDateTime completedAt) {
        return new Milestone(null, name, description, completedAt, true, false);
    }
}

