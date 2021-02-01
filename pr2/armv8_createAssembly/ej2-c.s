  .text
  .org 0x0000

  add x30, xzr, x16
  add x29, xzr, x17
product:
  add x30, x30, x16
  sub x29, x29, x1
  cbz x29, product
  stur x30, [x0]
