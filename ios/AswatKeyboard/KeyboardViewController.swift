import UIKit

/// Native iOS custom keyboard extension for Aswat al-Quloob.
///
/// This is a standalone keyboard extension target. To integrate it:
///   1. In Xcode, File > New > Target > Custom Keyboard Extension
///   2. Name it "AswatKeyboard"
///   3. Replace the generated KeyboardViewController with this file
///   4. Set the deployment target to iOS 15+
class KeyboardViewController: UIInputViewController {

    // MARK: - Layout data

    private var isShiftActive = false

    private let mainLayout: [[String]] = [
        ["ض", "ص", "ث", "ق", "ف", "غ", "ع", "ه", "خ", "ح", "ج"],
        ["ش", "س", "ي", "ب", "ل", "ا", "ت", "ن", "م", "ك"],
        ["ئ", "ء", "ؤ", "ر", "لا", "ى", "ة", "و", "ز", "ظ"],
    ]

    private let shiftLayout: [[String]] = [
        ["َ", "ً", "ُ", "ٌ", "لإ", "إ", "'", "÷", "×", "؛", "<"],
        ["ِ", "ٍ", "]", "[", "لأ", "أ", "ـ", "،", "/", ":"],
        ["~", "ْ", "}", "{", "لآ", "آ", "'", ",", ".", "؟"],
    ]

    private var keyboardStack: UIStackView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboard()
    }

    override func textWillChange(_ textInput: UITextInput?) {}
    override func textDidChange(_ textInput: UITextInput?) {}

    // MARK: - Build keyboard

    private func setupKeyboard() {
        guard let inputView = self.inputView else { return }
        inputView.backgroundColor = UIColor(red: 0.82, green: 0.82, blue: 0.84, alpha: 1)

        keyboardStack = UIStackView()
        keyboardStack.axis = .vertical
        keyboardStack.spacing = 6
        keyboardStack.translatesAutoresizingMaskIntoConstraints = false
        inputView.addSubview(keyboardStack)

        NSLayoutConstraint.activate([
            keyboardStack.leadingAnchor.constraint(equalTo: inputView.leadingAnchor, constant: 3),
            keyboardStack.trailingAnchor.constraint(equalTo: inputView.trailingAnchor, constant: -3),
            keyboardStack.topAnchor.constraint(equalTo: inputView.topAnchor, constant: 8),
            keyboardStack.bottomAnchor.constraint(equalTo: inputView.bottomAnchor, constant: -4),
        ])

        buildLayout()
    }

    private func buildLayout() {
        keyboardStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let layout = isShiftActive ? shiftLayout : mainLayout

        for (rowIndex, row) in layout.enumerated() {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 4
            rowStack.distribution = .fillEqually

            if rowIndex == 2 {
                let shiftBtn = makeKey(title: "⇧", isSpecial: true)
                shiftBtn.addTarget(self, action: #selector(shiftTapped), for: .touchUpInside)
                shiftBtn.widthAnchor.constraint(equalToConstant: 42).isActive = true
                rowStack.addArrangedSubview(shiftBtn)
            }

            for char in row {
                let key = makeKey(title: char)
                key.addTarget(self, action: #selector(keyTapped(_:)), for: .touchUpInside)
                rowStack.addArrangedSubview(key)
            }

            if rowIndex == 2 {
                let backBtn = makeKey(title: "⌫", isSpecial: true)
                backBtn.addTarget(self, action: #selector(backspaceTapped), for: .touchUpInside)
                backBtn.widthAnchor.constraint(equalToConstant: 42).isActive = true
                rowStack.addArrangedSubview(backBtn)
            }

            keyboardStack.addArrangedSubview(rowStack)
        }

        // Bottom row
        let bottom = UIStackView()
        bottom.axis = .horizontal
        bottom.spacing = 4

        let globe = makeKey(title: "🌐", isSpecial: true)
        globe.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        globe.widthAnchor.constraint(equalToConstant: 42).isActive = true
        bottom.addArrangedSubview(globe)

        let comma = makeKey(title: "،", isSpecial: true)
        comma.addTarget(self, action: #selector(keyTapped(_:)), for: .touchUpInside)
        comma.widthAnchor.constraint(equalToConstant: 42).isActive = true
        bottom.addArrangedSubview(comma)

        let space = makeKey(title: "أصوات القلوب")
        space.addTarget(self, action: #selector(spaceTapped), for: .touchUpInside)
        bottom.addArrangedSubview(space)

        let period = makeKey(title: ".", isSpecial: true)
        period.addTarget(self, action: #selector(keyTapped(_:)), for: .touchUpInside)
        period.widthAnchor.constraint(equalToConstant: 42).isActive = true
        bottom.addArrangedSubview(period)

        let ret = makeKey(title: "⏎", isSpecial: true)
        ret.backgroundColor = UIColor(red: 0.05, green: 0.45, blue: 0.47, alpha: 1)
        ret.setTitleColor(.white, for: .normal)
        ret.addTarget(self, action: #selector(returnTapped), for: .touchUpInside)
        ret.widthAnchor.constraint(equalToConstant: 42).isActive = true
        bottom.addArrangedSubview(ret)

        keyboardStack.addArrangedSubview(bottom)
    }

    // MARK: - Key factory

    private func makeKey(title: String, isSpecial: Bool = false) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = isSpecial
            ? .systemFont(ofSize: 16, weight: .medium)
            : .systemFont(ofSize: 22, weight: .regular)
        btn.setTitleColor(UIColor(red: 0.11, green: 0.11, blue: 0.12, alpha: 1), for: .normal)
        btn.backgroundColor = isSpecial
            ? UIColor(red: 0.68, green: 0.69, blue: 0.72, alpha: 1)
            : .white
        btn.layer.cornerRadius = 6
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 1)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 0.5
        btn.heightAnchor.constraint(equalToConstant: 42).isActive = true
        return btn
    }

    // MARK: - Actions

    @objc private func keyTapped(_ sender: UIButton) {
        guard let text = sender.title(for: .normal) else { return }
        textDocumentProxy.insertText(text)
        if isShiftActive {
            isShiftActive = false
            buildLayout()
        }
    }

    @objc private func backspaceTapped() {
        textDocumentProxy.deleteBackward()
    }

    @objc private func spaceTapped() {
        textDocumentProxy.insertText(" ")
    }

    @objc private func returnTapped() {
        textDocumentProxy.insertText("\n")
    }

    @objc private func shiftTapped() {
        isShiftActive.toggle()
        buildLayout()
    }
}
