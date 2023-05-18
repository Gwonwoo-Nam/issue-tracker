package com.issuetracker.dto;

import java.util.List;

import com.issuetracker.dto.issue.IssueDto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class IssueListDto {
    private List<IssueDto> issues;
    private List<FilterUserDto> userList;
    private List<FilterLabelDto> labelList;
    private List<FilterMilestoneDto> milestoneList;
    private Integer countAllLabels;
    private Integer countAllMilestones;
    private Long countOpenedIssues;
    private Long countClosedIssues;
}
