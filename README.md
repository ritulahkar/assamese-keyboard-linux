# assamese-keyboard-linux
Free assamese keyboard layout for linux

### Example of the Assamese as_ph Phenotypic Layout

![image](https://github.com/user-attachments/assets/d2b8f7c8-0e30-479b-abfb-3d914795a569)



Here are the instructions for adding the `as_ph` Assamese phenotypic layout to a system:

---

### Adding the Assamese `as_ph` Phenotypic Layout

To install the Assamese `as_ph` (phenotypic) keyboard layout, follow these steps:

#### 1. Clone the GitHub Repository
First, clone this repository to your local machine:
```bash
git clone https://github.com/ritulahkar/assamese-keyboard-linux.git
cd your-repo
```

#### 2. Copy the `as_ph` Symbols File
Next, you need to copy the `as_ph` symbols file to the XKB directory on your system:

```bash
sudo cp as_ph /usr/share/X11/xkb/symbols/
```

#### 3. Update the EVDEV XML File
Now, edit the `evdev.xml` file to add your layout to the list of available layouts.

- Open the `evdev.xml` file:

  ```bash
  sudo nano /usr/share/X11/xkb/rules/evdev.xml
  ```

- Search for the `<layoutList>` section. Just below the <layoutList> tag, within this section, add the following block:

  ```xml
  <layout>
      <configItem>
          <name>as_ph</name>
          <shortDescription>as_ph</shortDescription>
          <description>Assamese Phenotypic Layout</description>
          <languageList>
              <iso639Id>asm</iso639Id>
          </languageList>
      </configItem>
  </layout>
  ```
After this you will have to select the layout in the keyboard setings.

To do it through terminal do the following.

#### 4. Apply Changes and Set the Layout

After updating the XML file, you can now apply the new layout using:

```bash
setxkbmap as_ph
```

To make this layout persistent across reboots, follow the next step.

#### 5. Set as Default (Optional)

If you want to set this layout as your default Assamese layout:

- Open the keyboard configuration file:

  ```bash
  sudo nano /etc/default/keyboard
  ```

- Look for the line that starts with `XKBLAYOUT` and add `as_ph`:

  ```bash
  XKBLAYOUT="us,as_ph"
  ```

- Save and close the file, then restart your computer or apply the changes using:

  ```bash
  sudo dpkg-reconfigure keyboard-configuration
  ```

#### 6. Verify the Installation

You can verify the new layout by switching to it using your system's keyboard settings, or you can use the following command to test:

```bash
setxkbmap as_ph
```


# Assamese Keyboard Linux (অসমীয়া কীব'ৰ্ড লিনাক্স)
Linux ৰ বাবে ফ্ৰী অসমীয়া কীব'ৰ্ড লেআউট

### অসমীয়া as_ph ফেন'টাইপিক লেআউটৰ উদাহৰণ

![image](https://github.com/user-attachments/assets/d2b8f7c8-0e30-479b-abfb-3d914795a569)

ইয়াত অসমীয়া `as_ph` ফেন'টাইপিক কীব'ৰ্ড লেআউট যোগ কৰাৰ নিৰ্দেশনা দিয়া হৈছে:

অসমীয়া `as_ph` (ফেন'টাইপিক) কীব'ৰ্ড লেআউট ইনষ্টল কৰিবলৈ, তলৰ পদক্ষেপসমূহ অনুসৰণ কৰক:

#### ১. GitHub ৰেপ'জিট'ৰি ক্ল'ন কৰক
প্ৰথমে, এই ৰেপ'জিট'ৰি আপোনাৰ কম্পিউটাৰলৈ ক্ল'ন কৰক:
```bash
git clone https://github.com/ritulahkar/assamese-keyboard-linux.git
cd your-repo
```

#### ২. `as_ph` ছিম্ব'লছ ফাইল কপি কৰক
পিচত, `as_ph` ছিম্ব'লছ ফাইলটো XKB ডিৰেক্টৰীত কপি কৰক:

```bash
sudo cp as_ph /usr/share/X11/xkb/symbols/
```

#### ৩. EVDEV XML ফাইল আপডেট কৰক
এতিয়া, `evdev.xml` ফাইলটো সম্পাদনা কৰক যাতে আপোনাৰ লেআউট উপলব্ধ লেআউটত যোগ হয়।

- `evdev.xml` ফাইলটো খোলক:

  ```bash
  sudo nano /usr/share/X11/xkb/rules/evdev.xml
  ```

- `<layoutList>` বিচাৰিব। ইয়াৰ তলতে তলৰ ব্লকটো যোগ কৰক:

  ```xml
  <layout>
      <configItem>
          <name>as_ph</name>
          <shortDescription>as_ph</shortDescription>
          <description>Assamese Phenotypic Layout</description>
          <languageList>
              <iso639Id>asm</iso639Id>
          </languageList>
      </configItem>
  </layout>
  ```
  
ইয়াৰ পাছত, আপুনি কীব'ৰ্ড ছেটিংছত যাই লেআউটটো বাছনি কৰিব লাগিব।

এইটো টাৰমিনেলৰ জৰিয়তে কৰিবলৈ, তলৰ পদক্ষেপসমূহ অনুসৰণ কৰক:

#### ৪. পৰিৱৰ্তন প্ৰয়োগ কৰক আৰু লেআউটটো ছেট কৰক

XML ফাইল আপডেট কৰাৰ পিছত, নতুন লেআউটটো ব্যৱহাৰ কৰক:

```bash
setxkbmap as_ph
```

এই লেআউটটো ৰিবুটৰ পিছতো সংৰক্ষণ কৰিবলে তলৰ পদক্ষেপটো অনুসৰণ কৰক।

#### ৫. ডিফল্ট হিচাপে ছেট কৰক (বিকল্প)

যদি আপুনি এই লেআউটটো ডিফল্ট অসমীয়া লেআউট হিচাপে ছেট কৰিব বিচাৰে:

- কীব'ৰ্ড কনফিগাৰেচন ফাইলটো খোলক:

  ```bash
  sudo nano /etc/default/keyboard
  ```

- `XKBLAYOUT` বুলি আৰম্ভ হোৱা লাইনত `as_ph` যোগ কৰক:

  ```bash
  XKBLAYOUT="us,as_ph"
  ```

- ফাইলটো সংৰক্ষণ কৰি বন্ধ কৰক, পিচত কম্পিউটাৰটো ৰিষ্টাৰ্ট কৰক বা পৰিৱৰ্তনটো প্ৰয়োগ কৰক:

  ```bash
  sudo dpkg-reconfigure keyboard-configuration
  ```

#### ৬. ইনষ্টলেশন নিশ্চিত কৰক

আপুনি নতুন লেআউটটো নিশ্চিত কৰিব পাৰে কীব'ৰ্ড ছেটিংছ ব্যৱহাৰ কৰি, বা তলৰ কমাণ্ড ব্যৱহাৰ কৰি পৰীক্ষা কৰিব পাৰে:

```bash
setxkbmap as_ph
```

