// 12201919 윤종근
const slider = document.getElementById("slide");
const numberDisplay = document.getElementById("js-number-display");
const inputNumber = document.getElementById("num");
const printForm = document.getElementById("js-guess");
const display = document.getElementById("js-result");

function handleSliderInput(event) {
  const newMax = event.target.value;
  numberDisplay.textContent = newMax;
}

function handleResult(event) {
  event.preventDefault();
  const iN = inputNumber.value;
  const displaySpan = display.querySelector("span");
  const randomNumber = generateRandomNumber(0, numberDisplay.textContent);
  displaySpan.innerHTML = `You choose: ${iN}, the machine choose: ${randomNumber}.`;
  displaySpan.innerHTML += `<br>${handleCorrect(iN, randomNumber)}`;
}

function handleCorrect(self, other) {
  if (parseInt(self) === other) return "<strong>You win!</strong>";
  else return "<strong>You lost!<strong>";
}

function generateRandomNumber(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

slider.addEventListener("input", handleSliderInput);
printForm.addEventListener("submit", handleResult);
