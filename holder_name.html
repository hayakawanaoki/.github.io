//定数宣言
const firstNameInput = document.getElementById('firstName');
const lastNameInput = document.getElementById('lastName');
const firstNameError = document.getElementById('firstNameError');
const lastNameError = document.getElementById('lastNameError');
const nameLabel = document.getElementById('nameLabel');
const MAX_TOTAL_LENGTH = 22;
const ALLOWED_REGEXP = /^[A-Z.\-\/ ]+$/;
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

//関数宣言
const fetchSessionData = async () => {
    const res = await fetch('/holderName/session');
    if (res.ok) {
        const contentType = res.headers.get('content-type');
        if (contentType && contentType.includes('application/json')) {
            return await res.json();
        } else {
            // リダイレクト先に遷移
            window.location.href = res.headers.get('Location') || '/commonError';
            return null;
        }
    }
    return null;
};

const setInputValues = (firstName, lastName) => {
    if (firstName) {
        firstNameInput.value = firstName;
    }
    if (lastName) {
        lastNameInput.value = lastName;
    }
    updateNameLabel();
};

const updateNameLabel = () => {
    const firstName = firstNameInput.value.trim().toUpperCase() || firstNameInput.placeholder.toUpperCase();
    const lastName = lastNameInput.value.trim().toUpperCase() || lastNameInput.placeholder.toUpperCase();
    nameLabel.textContent = `${firstName} ${lastName}`.trim();
};

const handleBlurAndUpdateLabel = (input) => {
    input.value = input.value.toUpperCase();
    updateNameLabel();
}

const limitInputLength = (currentInput, otherInput) => {
    const currentLength = currentInput.value.length;
    const otherLength = otherInput.value.length;
    const remainingLength = MAX_TOTAL_LENGTH - otherLength;
    if (currentLength > remainingLength) {
        currentInput.value = currentInput.value.slice(0, remainingLength);
    }
};

const removeFullWidthSpaces = (str) => {
    return str.replace(/^[\u3000]+|[\u3000]+$/g, '');
}

const showError = async (messageId, errorElem, inputElem) => {
    try {
        const locale = navigator.language || "ja";
        const res = await fetch(
            `/api/message?messageIds=${encodeURIComponent(messageId)}&locale=${encodeURIComponent(locale)}`
        );
        const data = await res.json();
        const message = data.messageText || "エラーが発生しました";
        errorElem.innerText = message;
        errorElem.classList.add("show");
        inputElem.classList.add("error");
    } catch (e) {
        errorElem.innerText = "エラーが発生しました";
        errorElem.classList.add("show");
    }
};

const hideError = (errorElem, inputElem) => {
    errorElem.innerText = "";
    errorElem.classList.remove("show");
    if (inputElem) {
        inputElem.classList.remove("error");
    }
};

const isValidName = (value) => {
    if (!value) return false;
    return ALLOWED_REGEXP.test(value);
};

const clearErrorIfValid = (inputElem, errorElem) => {
    const raw = removeFullWidthSpaces(inputElem.value);
    if (isValidName(raw)) {
        hideError(errorElem, inputElem);
    }
};

const saveHolderName = async (firstName, lastName) => {
    await fetch('/holderName/session', {
        method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                [csrfHeader]: csrfToken
            },
        body: `firstName=${encodeURIComponent(firstName)}&lastName=${encodeURIComponent(lastName)}`
    });
};

document.addEventListener('DOMContentLoaded', async () => {
    const sessionData = await fetchSessionData();
    const holderName = sessionData?.holderName || {};
    const transactionType = sessionData?.transactionType;
    const design = sessionData?.design;

    setInputValues(holderName.firstName, holderName.lastName);

    if (design) {
        if (design.name_img) {
            const guideImage = document.getElementById('guideImage');
            if (guideImage) {
                guideImage.src = design.name_img;
            }
        }
        if (design.name_font_color) {
            const nameLabel = document.getElementById('nameLabel');
            if (nameLabel) {
                nameLabel.style.color = design.name_font_color;
            }
        }
    }

    updateNameLabel();

    firstNameInput.addEventListener('input', () => limitInputLength(firstNameInput, lastNameInput));
    lastNameInput.addEventListener('input', () => limitInputLength(lastNameInput, firstNameInput));
    firstNameInput.addEventListener('blur', () => {
        handleBlurAndUpdateLabel(firstNameInput);
        clearErrorIfValid(firstNameInput, firstNameError);
    });
    lastNameInput.addEventListener('blur', () => {
        handleBlurAndUpdateLabel(lastNameInput);
        clearErrorIfValid(lastNameInput, lastNameError);
    });


    document.getElementById('continueButton').addEventListener('click', async () => {
        const firstNameValue = removeFullWidthSpaces(firstNameInput.value);
        const lastNameValue = removeFullWidthSpaces(lastNameInput.value);
        let hasError = false;

        hideError(firstNameError, firstNameInput);
        hideError(lastNameError, lastNameInput);

        // クライアント側バリデーション
        if (!firstNameValue) {
            await showError('MEC01AEW01', firstNameError, firstNameInput);
            hasError = true;
        } else if (!ALLOWED_REGEXP.test(firstNameValue)) {
            await showError('MEC01AEW02', firstNameError, firstNameInput);
            hasError = true;
        }
        if (!lastNameValue) {
            await showError('MEC01AEW01', lastNameError, lastNameInput);
            hasError = true;
        } else if (!ALLOWED_REGEXP.test(lastNameValue)) {
            await showError('MEC01AEW02', lastNameError, lastNameInput);
            hasError = true;
        }
        if (hasError) return;

        // サーバ側バリデーション
        const response = await fetch('/holderName/valName', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                [csrfHeader]: csrfToken
            },
            body: `firstName=${encodeURIComponent(firstNameValue)}&lastName=${encodeURIComponent(lastNameValue)}`
        });
        const result = await response.text();
        if (result) {
            const parts = result.split(':');
            const messageId = parts[0];
            const field = parts[1];
            if (field === "FIRST") {
                await showError(messageId, firstNameError, firstNameInput);
                return;
            } else if (field === "LAST") {
                await showError(messageId, lastNameError, lastNameInput);
                return;
            } else if (field === undefined)  {
                await showError(messageId, firstNameError, firstNameInput);
            }
        }

        // ここまで来たら全てOKなので格納
        await saveHolderName(firstNameValue, lastNameValue);
        window.location.href = '/pinSetup'; // 暗証番号設定画面への遷移
    });
});
