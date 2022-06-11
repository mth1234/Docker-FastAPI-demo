# python3.9�̃C���[�W���_�E�����[�h
FROM python:3.9-buster
ENV PYTHONUNBUFFERED=1

WORKDIR /src

# pip���g����poetry���C���X�g�[��
RUN pip install poetry

# poetry�̒�`�t�@�C�����R�s�[ (���݂���ꍇ)
COPY pyproject.toml* poetry.lock* ./

# poetry�Ń��C�u�������C���X�g�[�� (pyproject.toml�����ɂ���ꍇ)
RUN poetry config virtualenvs.in-project true
RUN if [ -f pyproject.toml ]; then poetry install; fi

# uvicorn�̃T�[�o�[�𗧂��グ��
ENTRYPOINT ["poetry", "run", "uvicorn", "api.main:app", "--host", "0.0.0.0", "--reload"]