import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildResponseText(String text) {
  /// Split text by double newlines for paragraphs
  List<String> paragraphs = text.split('\n\n');
  List<Widget> paragraphWidgets = [];

  for (String paragraph in paragraphs) {
    List<TextSpan> spans = _parseMarkdown(paragraph);
    paragraphWidgets.add(RichText(
      text: TextSpan(children: spans),
    ));
    /// Add spacing between paragraphs
    paragraphWidgets.add(SizedBox(height: 8.h));
  }

  /// Remove the last SizedBox to avoid extra spacing
  if (paragraphWidgets.isNotEmpty) {
    paragraphWidgets.removeLast();
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: paragraphWidgets,
  );
}

/// Function to parse markdown-like formatting and create TextSpans
List<TextSpan> _parseMarkdown(String response) {
  List<TextSpan> spans = [];

  /// Regex to handle ** for bold, ### for headers, * for bullets, _ for italics, __ for underlines
  RegExp regex = RegExp(
      r'(\*\*(.*?)\*\*|### (.*?)(?:\n|$)|(\* (.*?)(?:\n|$))|\_(.*?)\_|__(.*?)__)');
  Iterable<RegExpMatch> matches = regex.allMatches(response);

  int lastMatchEnd = 0;

  /// Iterate through all matches and build TextSpans with appropriate styles
  for (var match in matches) {
    /// Text before current match (normal text)
    if (match.start > lastMatchEnd) {
      // Split by single newlines to handle list items or inline breaks
      List<String> subParts =
      response.substring(lastMatchEnd, match.start).split('\n');
      for (int i = 0; i < subParts.length; i++) {
        if (subParts[i].isNotEmpty) {
          spans.add(TextSpan(
            text: subParts[i],
            style: TextStyle(color: Colors.white),
          ));
        }
        if (i < subParts.length - 1) {
          spans.add(TextSpan(
            text: '\n',
            style: TextStyle(color: Colors.white),
          ));
        }
      }
    }

    /// Check for bold (**)
    if (match.group(1) != null) {
      spans.add(TextSpan(
        text: match.group(2),
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ));
    }

    // Check for headers (###)
    else if (match.group(3) != null) {
      spans.add(TextSpan(
        text: match.group(3),
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ));
    }

    // Check for bullet points (*)
    else if (match.group(4) != null) {
      spans.add(TextSpan(
        text: '• ${match.group(5)}',
        style: TextStyle(color: Colors.white),
      ));
    }

    // Check for italics (_)
    else if (match.group(6) != null) {
      spans.add(TextSpan(
        text: match.group(6),
        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
      ));
    }

    // Check for underline (__)
    else if (match.group(7) != null) {
      spans.add(TextSpan(
        text: match.group(7),
        style: TextStyle(decoration: TextDecoration.underline, color: Colors.white),
      ));
    }

    lastMatchEnd = match.end;
  }

  // Add the remaining text after the last match
  if (lastMatchEnd < response.length) {
    List<String> subParts = response.substring(lastMatchEnd).split('\n');
    for (int i = 0; i < subParts.length; i++) {
      if (subParts[i].isNotEmpty) {
        spans.add(TextSpan(
          text: subParts[i],
          style: TextStyle(color: Colors.white),
        ));
      }
      if (i < subParts.length - 1) {
        spans.add(TextSpan(
          text: '\n',
          style: TextStyle(color: Colors.white),
        ));
      }
    }
  }

  return spans;
}