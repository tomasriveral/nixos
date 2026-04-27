Control dashboard: http://localhost:631

---

# 🧾 Core controls

```bash
lp file.pdf
```

```bash
-d PRINTER        # choose printer
-n NUM            # number of copies
-t "TITLE"        # job name
-q NUM            # priority (1–100, higher = sooner)
```
Printer at the house: `HP_OfficeJet_Pro_7740`. I can't make printing without USB work...

---

## If printer stuck:

```bash id="enable1"
sudo cupsenable HP_OfficeJet_Pro_7740
```

---


```bash id="accept1"
sudo cupsaccept HP_OfficeJet_Pro_7740
```


```bash id="cancel1"
cancel -a HP_OfficeJet_Pro_7740
```


#### 🧪 Verify state

```bash id="check1"
lpstat -p -d
```

You want:

```
HP_OfficeJet_Pro_7740 idle, accepting jobs
```

---

# 📄 Page selection

```bash
-P 1-5,8,10-20    # specific pages / ranges
-o page-ranges=   # same as -P (sometimes more reliable)
```

Example:

```bash
lp -o page-ranges=142-184 file.pdf
```

---

# 📐 Layout & scaling

```bash
-o fit-to-page
-o scaling=100        # percent
-o media=A4
-o orientation-requested=4   # landscape
```

Orientation values:

* `3` = portrait
* `4` = landscape

---

# 🧠 Duplex (double-sided)

```bash
-o sides=one-sided
-o sides=two-sided-long-edge
-o sides=two-sided-short-edge
```

---

# 📚 Multiple pages per sheet

```bash
-o number-up=2
-o number-up=4
-o number-up=6
-o number-up=9
-o number-up=16
```

---

# 🖼️ Image handling

```bash
-o fit-to-page
-o position=center
-o saturation=100
-o brightness=100
```

---

# 🎨 Color / quality

```bash
-o ColorModel=Color
-o ColorModel=Gray

-o print-quality=3   # draft
-o print-quality=4   # normal
-o print-quality=5   # high
```

---

# 📦 Paper / tray

```bash
-o media=A4
-o media=Letter
-o InputSlot=tray1
-o InputSlot=manual
```

---

# 🔁 Job handling

```bash
-H hold            # hold job
-H resume          # resume job
-H immediate       # print ASAP
```

---

# 🔍 Debug / info

```bash
lpstat -p -d       # printers + default
lpstat -o          # jobs
lpoptions -l       # printer-specific options
```

---

# 🔥 Real-world example (what you actually want)

```bash
lp -d HP_LaserJet \
   -o page-ranges=142-184 \
   -o sides=two-sided-long-edge \
   -o media=A4 \
   -o print-quality=5 \
   file.pdf
```

---

# ⚠️ Important reality check

Not all printers support all options. The **real supported ones** come from:

```bash
lpoptions -p PRINTER_NAME -l
```

That command is gold—use it.

---

If you want, tell me your **printer model**, and I’ll give you a *perfect command tuned to it* (no guessing, no trial and error).
