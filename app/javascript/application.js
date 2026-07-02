import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {

  // ===== 要素取得 =====
  const input = document.getElementById("answer");
  const word = document.getElementById("word");
  const timer = document.getElementById("timer");
  const score = document.getElementById("score");
  const wordsData = document.getElementById("words");

  if (!input || !wordsData) return;

  // ===== 単語一覧 =====
  const words = JSON.parse(wordsData.dataset.words);

  let index = 0;
  let point = 0;
  let miss = 0;
  let remaining = 30;

  // ===== 最初の問題 =====
  word.textContent = words[index];

  // ===== 自動フォーカス =====
  input.focus();

  document.addEventListener("click", () => {
    input.focus();
  });

  // ===== Escキー =====
  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape") {
      if (confirm("ゲームを中断しますか？")) {
        window.location.href = "/start";
      }
    }
  });

  // ===== タイマー =====
  const countdown = setInterval(() => {

    remaining--;
    timer.textContent = remaining;

    if (remaining <= 0) {
      clearInterval(countdown);
      finishGame();
    }

  }, 1000);

  // ===== 入力 =====
  input.addEventListener("input", () => {

    // アルファベットとハイフンだけ許可
    input.value = input.value.replace(/[^a-zA-Z-]/g, "").toLowerCase();

    const correct = words[index];

    // 途中まで合っているか
    if (!correct.startsWith(input.value)) {

      // 間違った文字は消す
      input.value = input.value.slice(0, -1);

      miss++;

      return;
    }

    // 全部一致
    if (input.value === correct) {

      point += 100;
      score.textContent = point;

      index++;

      if (index >= words.length) {
        index = 0;
      }

      word.textContent = words[index];

      input.value = "";

    }

  });

  // ===== 終了 =====
  function finishGame() {

    fetch("/finish", {

      method: "POST",

      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token":
          document.querySelector('meta[name="csrf-token"]').content
      },

      body: JSON.stringify({
        score: point,
        count: index,
        miss: miss
      })

    }).then(() => {
      location.href = "/result";
    });

  }

});