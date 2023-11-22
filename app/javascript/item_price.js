const priceInput = document.getElementById("item-price");
const addTaxDom = document.getElementById("add-tax-price");
const addProfit = document.getElementById("profit");

priceInput.addEventListener("input", () => {
  const inputValue = parseFloat(priceInput.value);

  // inputValue が数値でない場合は 0 に設定
  const validInputValue = isNaN(inputValue) ? 0 : inputValue;


  // 販売手数料の計算
  const taxAmount = Math.floor(validInputValue * 0.1);
  addTaxDom.innerHTML = taxAmount; // 切り捨てた10%の数値を表記

  // 利益の計算
  const profitAmount = Math.floor(validInputValue - taxAmount);
  addProfit.innerHTML = profitAmount; // 切り捨てた利益の数値を表記
});