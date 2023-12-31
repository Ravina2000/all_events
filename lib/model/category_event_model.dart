class CategoryEventModel {
  Request? request;
  int? count;
  List<Item>? item;

  CategoryEventModel({this.request, this.count, this.item});

  CategoryEventModel.fromJson(Map<String, dynamic> json) {
    request =
        json['request'] != null ? new Request.fromJson(json['request']) : null;
    count = json['count'];
    if (json['item'] != null) {
      item = <Item>[];
      json['item'].forEach((v) {
        item!.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    data['count'] = this.count;
    if (this.item != null) {
      data['item'] = this.item!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Request {
  String? venue;
  String? ids;
  String? type;
  String? city;
  int? edate;
  int? page;
  String? keywords;
  int? sdate;
  String? category;
  String? cityDisplay;
  int? rows;

  Request(
      {this.venue,
      this.ids,
      this.type,
      this.city,
      this.edate,
      this.page,
      this.keywords,
      this.sdate,
      this.category,
      this.cityDisplay,
      this.rows});

  Request.fromJson(Map<String, dynamic> json) {
    venue = json['venue'];
    ids = json['ids'];
    type = json['type'];
    city = json['city'];
    edate = json['edate'];
    page = json['page'];
    keywords = json['keywords'];
    sdate = json['sdate'];
    category = json['category'];
    cityDisplay = json['city_display'];
    rows = json['rows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['venue'] = this.venue;
    data['ids'] = this.ids;
    data['type'] = this.type;
    data['city'] = this.city;
    data['edate'] = this.edate;
    data['page'] = this.page;
    data['keywords'] = this.keywords;
    data['sdate'] = this.sdate;
    data['category'] = this.category;
    data['city_display'] = this.cityDisplay;
    data['rows'] = this.rows;
    return data;
  }
}

class Item {
  String? eventId;
  String? eventname;
  String? eventnameRaw;
  String? ownerId;
  String? thumbUrl;
  String? thumbUrlLarge;
  int? startTime;
  String? startTimeDisplay;
  int? endTime;
  String? endTimeDisplay;
  String? location;
  Venue? venue;
  String? label;
  int? featured;
  String? eventUrl;
  String? shareUrl;
  String? bannerUrl;
  double? score;
  List<String>? categories;
  List<String>? tags;
  Tickets? tickets;
  List<dynamic>? customParams;

  Item(
      {this.eventId,
      this.eventname,
      this.eventnameRaw,
      this.ownerId,
      this.thumbUrl,
      this.thumbUrlLarge,
      this.startTime,
      this.startTimeDisplay,
      this.endTime,
      this.endTimeDisplay,
      this.location,
      this.venue,
      this.label,
      this.featured,
      this.eventUrl,
      this.shareUrl,
      this.bannerUrl,
      this.score,
      this.categories,
      this.tags,
      this.tickets,
      this.customParams});

  Item.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventname = json['eventname'];
    eventnameRaw = json['eventname_raw'];
    ownerId = json['owner_id'];
    thumbUrl = json['thumb_url'];
    thumbUrlLarge = json['thumb_url_large'];
    startTime = json['start_time'];
    startTimeDisplay = json['start_time_display'];
    endTime = json['end_time'];
    endTimeDisplay = json['end_time_display'];
    location = json['location'];
    venue = json['venue'] != null ? new Venue.fromJson(json['venue']) : null;
    label = json['label'];
    featured = json['featured'];
    eventUrl = json['event_url'];
    shareUrl = json['share_url'];
    bannerUrl = json['banner_url'];
    score = json['score'].toDouble();
    categories = json['categories'].cast<String>();
    tags = json['tags'].cast<String>();
    tickets =
        json['tickets'] != null ? new Tickets.fromJson(json['tickets']) : null;
    if (json['custom_params'] != null) {
      customParams = json['custom_params'].cast<dynamic>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['eventname'] = this.eventname;
    data['eventname_raw'] = this.eventnameRaw;
    data['owner_id'] = this.ownerId;
    data['thumb_url'] = this.thumbUrl;
    data['thumb_url_large'] = this.thumbUrlLarge;
    data['start_time'] = this.startTime;
    data['start_time_display'] = this.startTimeDisplay;
    data['end_time'] = this.endTime;
    data['end_time_display'] = this.endTimeDisplay;
    data['location'] = this.location;
    if (this.venue != null) {
      data['venue'] = this.venue!.toJson();
    }
    data['label'] = this.label;
    data['featured'] = this.featured;
    data['event_url'] = this.eventUrl;
    data['share_url'] = this.shareUrl;
    data['banner_url'] = this.bannerUrl;
    data['score'] = this.score;
    data['categories'] = this.categories;
    data['tags'] = this.tags;
    if (this.tickets != null) {
      data['tickets'] = this.tickets!.toJson();
    }
    if (this.customParams != null) {
      data['custom_params'] =
          this.customParams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Venue {
  String? street;
  String? city;
  String? state;
  String? country;
  double? latitude;
  double? longitude;
  String? fullAddress;

  Venue(
      {this.street,
      this.city,
      this.state,
      this.country,
      this.latitude,
      this.longitude,
      this.fullAddress});

  Venue.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'].toDouble();
    longitude = json['longitude'].toDouble();
    fullAddress = json['full_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['full_address'] = this.fullAddress;
    return data;
  }
}

class Tickets {
  bool? hasTickets;
  String? ticketUrl;
  String? ticketCurrency;
  int? minTicketPrice;
  int? maxTicketPrice;

  Tickets(
      {this.hasTickets,
      this.ticketUrl,
      this.ticketCurrency,
      this.minTicketPrice,
      this.maxTicketPrice});

  Tickets.fromJson(Map<String, dynamic> json) {
    hasTickets = json['has_tickets'];
    ticketUrl = json['ticket_url'];
    ticketCurrency = json['ticket_currency'];
    minTicketPrice = json['min_ticket_price'];
    maxTicketPrice = json['max_ticket_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['has_tickets'] = this.hasTickets;
    data['ticket_url'] = this.ticketUrl;
    data['ticket_currency'] = this.ticketCurrency;
    data['min_ticket_price'] = this.minTicketPrice;
    data['max_ticket_price'] = this.maxTicketPrice;
    return data;
  }
}
