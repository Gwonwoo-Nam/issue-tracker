package com.issuetracker.service;

import static com.issuetracker.mapper.LabelMapper.*;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.stereotype.Service;

import com.issuetracker.domain.Label;
import com.issuetracker.dto.label.LabelDto;
import com.issuetracker.dto.label.LabelListDto;
import com.issuetracker.mapper.LabelMapper;
import com.issuetracker.repository.LabelRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LabelService {
    private final LabelRepository labelRepository;

    public Label createLabel(Label label) {
        return labelRepository.save(label);
    }

    public Label findLabelById(int labelId) {
        return labelRepository.findById(labelId).orElseThrow(() -> new IllegalArgumentException("라벨이 없습니다."));
    }

    public LabelListDto findAllLabels() throws SQLException {
        List<Label> labelList = labelRepository.findAllLabels();

        List<LabelDto> labelDtoList = new ArrayList<>();
        for (Label label : labelList) {
            labelDtoList.add(mapLabelEntityToDto(label));
        }

        return new LabelListDto(labelDtoList, labelDtoList.size());
    }

    /**
     * Label Id로 삭제합니다.
     * 예외처리 추가 필요
     * @param labelId
     */
    public Label deleteLabelById(int labelId) {
        Label label = labelRepository.findById(labelId).orElseThrow(() -> new IllegalArgumentException("없는 라벨입니다."));
        label.setDeleted(true);

        return labelRepository.save(label);
    }

    public Label updateLabel(Label label) {
        return labelRepository.save(label);
    }
}
