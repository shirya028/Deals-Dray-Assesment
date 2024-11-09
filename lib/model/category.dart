class Category {
  final String label;
  final String icon;

  // Constructor using positional parameters
  Category(this.label, this.icon);

  // Factory constructor for JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      json['label'] as String,
      json['icon'] as String,
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'icon': icon,
    };
  }
}
