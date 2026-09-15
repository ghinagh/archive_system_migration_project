package com.startupstack.app.modules.digitization.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * Progress and outcome of a batch delivery.
 *
 * <p>Legacy ran these batches synchronously, blocking the whole form on
 * {@code WaitForSingleObject(..., INFINITE)} while ffmpeg worked, and reported progress by
 * writing the current item's title into the {@code m_tit} textbox (:4222-4232). A single HTTP
 * request cannot block for the length of a multi-clip transcode, so the batch runs as a job
 * and the client polls this — {@code currentTitle} and {@code processed}/{@code total} carry
 * exactly what {@code m_tit} showed.
 *
 * <p>The three terminal outcomes reproduce legacy's three message boxes: everything done,
 * nothing selected, or a list of the stock numbers that could not be processed
 * ("ارقام الاشرطة التي لم تنفذ").
 */
@Getter
@Setter
public class DeliveryJobStatus {

    public enum State { RUNNING, COMPLETED, FAILED }

    private String jobId;
    private State state = State.RUNNING;

    private int total;
    private int processed;
    /** Description of the item being worked on — legacy's m_tit / m_tit1 text. */
    private String currentTitle;

    private int succeeded;
    /** Stock numbers legacy would list in "ارقام الاشرطة التي لم تنفذ". */
    private List<String> failedStockNumbers = new ArrayList<>();
    /** Set only when the job itself failed, as opposed to individual items. */
    private String errorMessage;

    /** True when the batch matched no queued rows — legacy "لا يوجد مواد مختارة للتنفيذ". */
    private boolean nothingSelected;

    /** Server-side paths of the produced files, offered to the user for download. */
    private List<String> outputPaths = new ArrayList<>();

    /** How many clips reached the external EDLC system; below {@code succeeded} when it is unavailable. */
    private int handedOffToEdlc;
}
