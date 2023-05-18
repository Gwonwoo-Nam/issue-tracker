package com.issuetracker.service;

import com.issuetracker.dto.FilterLabelDto;
import com.issuetracker.dto.FilterMilestoneDto;
import com.issuetracker.dto.FilterUserDto;
import com.issuetracker.dto.IssueDto;
import com.issuetracker.dto.IssueLabelDto;
import com.issuetracker.dto.IssueListDto;
import com.issuetracker.dto.IssueDao;
import com.issuetracker.repository.LabelRepository;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class LabelService {
    private final LabelRepository labelRepository;

    public IssueListDto fetchMain() {
        IssueListDto issueListDto = new IssueListDto();
        List<IssueDao> issueMainPageDtoList = labelRepository.getIssues(true);

        List<IssueDto> issueDtoList = new ArrayList<>();
        for (int i = 0; i < issueMainPageDtoList.size(); i++) {
            IssueDao issueDao = issueMainPageDtoList.get(i);
            long id = issueDao.getId();
            List<IssueLabelDto> issueLabelDtoList = new ArrayList<>();
            IssueDto issueDto = new IssueDto(id, issueDao.getTitle(), issueDao.getContent(), issueDao.getUserName(),
                    issueDao.getProfileUrl(), issueDao.getOpened(), issueDao.getCreatedAt(), issueDao.getClosedAt(),
                    issueDao.getMilestoneName(), issueLabelDtoList);
            Boolean flag = false;
            while (i < issueMainPageDtoList.size() && id == issueDao.getId()) {
                flag = true;
                if (issueDao.getLabelId() != null) {
                    issueLabelDtoList.add(
                            new IssueLabelDto(issueDao.getLabelId(), issueDao.getLabelName(),
                                    issueDao.getBackgroundColor(),
                                    issueDao.getFontColor()));
                }
                i++;
                if (i < issueMainPageDtoList.size()) {
                    issueDao = issueMainPageDtoList.get(i);
                }
            }
            issueDtoList.add(issueDto);
            if (flag) {
                i--;
            }
        }
        issueListDto.setIssues(issueDtoList);
        issueListDto.setUserList(fetchFilterUsers());
        List<FilterLabelDto> filterLabelDtoList = fetchFilterLabels();
        issueListDto.setLabelList(filterLabelDtoList);
        List<FilterMilestoneDto> filterMilestoneDtoList = fetchFilterMilestones();
        issueListDto.setMilestoneList(filterMilestoneDtoList);

        issueListDto.setCountAllLabels(filterLabelDtoList.size());
        issueListDto.setCountAllMilestones(filterMilestoneDtoList.size());
        issueListDto.setCountOpenedIssues(issueDtoList.stream().filter(issueDto -> issueDto.getIsOpen()).count());
        issueListDto.setCountClosedIssues(labelRepository.getTotalClosedIssueCount());
        return issueListDto;
    }

    public List<FilterUserDto> fetchFilterUsers() {
        return labelRepository.getFilterUserList();
    }

    public List<FilterLabelDto> fetchFilterLabels() {
        return labelRepository.getFilterLabelList();
    }

    public List<FilterMilestoneDto> fetchFilterMilestones() {
        return labelRepository.getFilterMilestoneList();
    }

}
