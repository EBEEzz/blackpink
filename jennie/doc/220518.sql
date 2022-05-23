CREATE TABLE reboard(
	rbno NUMBER(6)
		CONSTRAINT RBRD_NO_PK PRIMARY KEY,
	upno NUMBER(6),
	rbmno NUMBER(4)
		CONSTRAINT RBRD_MNO_FK REFERENCES member(mno)
		CONSTRAINT RBRD_MNO_NN NOT NULL,
	body VARCHAR2(200 CHAR)
		CONSTRAINT RBRD_BODY_NN NOT NULL,
	wdate DATE DEFAULT sysdate
		CONSTRAINT RBRD_DATE_NN NOT NULL,
	isshow CHAR(1) DEFAULT 'Y'
		CONSTRAINT RBRD_SHOW_CK CHECK(isshow IN('Y', 'N'))
		CONSTRAINT RBRD_SHOW_NN NOT NULL
);

INSERT INTO
    reboard(rbno, upno, rbmno, body)
VALUES(
    (SELECT NVL(MAX(rbno) + 1, 100001) FROM reboard),
    NULL, 1000, '댓글게시판 오픈합니다.'
);

INSERT INTO
    reboard(rbno, upno, rbmno, body)
VALUES(
    (SELECT NVL(MAX(rbno) + 1, 100001) FROM reboard),
    100001, 1001, '게시판 오픈 축하합니다.'
);

INSERT INTO
    reboard(rbno, upno, rbmno, body)
VALUES(
    (SELECT NVL(MAX(rbno) + 1, 100001) FROM reboard),
    100002, 1004, '저도 오픈 축하합니다.'
);

INSERT INTO
    reboard(rbno, upno, rbmno, body)
VALUES(
    (SELECT NVL(MAX(rbno) + 1, 100001) FROM reboard),
    100002, 1002, '저두요...'
);

INSERT INTO
    reboard(rbno, upno, rbmno, body)
VALUES(
    (SELECT NVL(MAX(rbno) + 1, 100001) FROM reboard),
    100001, 1005, '오픈 감축드립니다.'
);

COMMIT;

SELECT
    rno, rbno, upno, mno, id, body, savename, wdate, step
FROM
    (
        SELECT
            ROWNUM rno, rbno, upno, mno, id, body, savename, wdate, step
        FROM
            (
                SELECT
                    rbno, upno, mno, id, body, savename, wdate, (level - 1) step
                FROM
                    reboard r, member m, avatar a
                WHERE
                    r.isshow = 'Y'
                    AND rbmno = mno
                    AND avt = ano
                START WITH
                    upno IS NULL
                CONNECT BY
                    PRIOR rbno = upno
                ORDER SIBLINGS BY
                    wdate DESC
            )
    )
WHERE
    rno BETWEEN ? AND ?
;

--220519
SELECT
    rbno, upno, rbmno, wdate, level, (level - 1) step
FROM
    reboard
START WITH
    upno IS NULL
CONNECT BY
    PRIOR rbno = upno
ORDER SIBLINGS BY
    wdate DESC
;

SELECT
    mno, savename
FROM
    member m, avatar a
WHERE
    m.isshow = 'Y'
    AND avt = ano
    AND id = 'jennie'
;

INSERT INTO
    reboard(rbno, upno, rbmno, body)
VALUES(
    (SELECT NVL(MAX(rbno) + 1, 100001) FROM reboard),
    ?, ?, ?
)
;

SELECT
    rbno, body, id, savename
FROM
	reboard r, member m, avatar a
WHERE
	r.isshow = 'Y'
	AND rbno = ?
	AND avt = ano
	AND id = ?
;


--220520

UPDATE 
    reboard
SET
    isshow = 'N'
WHERE
    rbno = ?
;

CREATE TABLE board(
    bno     NUMBER(6)
        CONSTRAINT BRD_NO_PK PRIMARY KEY,
    bmno    NUMBER(4)
        CONSTRAINT BRD_MNO_FK REFERENCES member(mno)
        CONSTRAINT BRD_MNO_NN NOT NULL,
    title   VARCHAR2(30 CHAR)
        CONSTRAINT BRD_TTL_NN NOT NULL,
    body    VARCHAR2(4000)
        CONSTRAINT BRD_BODY_NN NOT NULL,
    wdate   DATE DEFAULT sysdate
        CONSTRAINT BRD_DATE_NN NOT NULL,        
    click   NUMBER(4)   DEFAULT 0
        CONSTRAINT BRD_CLICK_NN NOT NULL,
    isshow  CHAR(1) DEFAULT 'Y'
        CONSTRAINT BRD_SHOW_CK CHECK (isshow IN('Y', 'N'))
        CONSTRAINT BRD_SHOW_NN NOT NULL
);

CREATE TABLE fileinfo(
    fno NUMBER(8)
        CONSTRAINT FI_NO_PK PRIMARY KEY,
    fbno NUMBER(6)
        CONSTRAINT FI_BNO_FK REFERENCES board(bno)
        CONSTRAINT FI_BNO_NN NOT NULL,
    oriname VARCHAR2(50 CHAR)
        CONSTRAINT FI_ONAME_NN NOT NULL,        
    savename VARCHAR2(50 CHAR)
        CONSTRAINT FI_SNAME_UK UNIQUE
        CONSTRAINT FI_SNAME_NN NOT NULL,
    dir VARCHAR2(200 CHAR)
        CONSTRAINT FI_DIR_NN NOT NULL,
    len NUMBER
        CONSTRAINT FI_LEN_NN NOT NULL,
    savedate DATE DEFAULT sysdate
        CONSTRAINT FI_SDATE_NN NOT NULL,
    isshow CHAR(1) DEFAULT 'Y'
        CONSTRAINT FI_SHOW_CK CHECK(isshow IN('Y', 'N'))
        CONSTRAINT FI_SHOW_NN NOT NULL
);