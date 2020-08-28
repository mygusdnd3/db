



SELECT
*
FROM
EMP
WHERE
    LENGTH(ENAME) = ( SELECT
                        LENGTH(ENAME)
                      FROM
                        EMP
                        WHERE
                            SAL = (
                                    SELECT
                                        MAX(SAL)
                                        FROM
                                            EMP
                                        )