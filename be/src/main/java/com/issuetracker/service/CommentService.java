package com.issuetracker.service;

import com.issuetracker.domain.Comment;
import com.issuetracker.dto.comment.CommentPostDto;
import com.issuetracker.repository.CommentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@Service
@RequiredArgsConstructor
public class CommentService {

    private final CommentRepository commentRepository;

    public void createComment(CommentPostDto commentPostDto, long issueId) {
        commentRepository.save(Comment.createComment(commentPostDto, issueId));
    }

    public void modifyComment(CommentPostDto commentPostDto, long issueId, long commentId) {
        /**
         * TODO 예외처리
         * - 없거나 삭제된 issueId 또는
         * - unmodifiedComment의 작성자와 요청한 사람이 다르면
         * - 400 또는 404 리턴
         */
        Comment unmodifiedComment = commentRepository.findById(commentId).get();
        Comment comment = commentRepository.save(Comment.updateComment(commentPostDto, unmodifiedComment, commentId, issueId));
    }
}
