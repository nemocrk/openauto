#pragma once

#include <functional>
#include <mutex>

#include <aap_protobuf/service/mediaplayback/message/MediaPlaybackMetadata.pb.h>
#include <aap_protobuf/service/mediaplayback/message/MediaPlaybackStatus.pb.h>
#include <aap_protobuf/service/navigationstatus/message/NavigationStatus.pb.h>
#include <aap_protobuf/service/navigationstatus/message/NavigationNextTurnEvent.pb.h>
#include <aap_protobuf/service/navigationstatus/message/NavigationNextTurnDistanceEvent.pb.h>

namespace f1x::openauto::autoapp::service {

struct EventCallbacks {
  std::function<void(const aap_protobuf::service::mediaplayback::message::MediaPlaybackMetadata&)> onMediaMetadata;
  std::function<void(const aap_protobuf::service::mediaplayback::message::MediaPlaybackStatus&)> onMediaPlayback;
  std::function<void(const aap_protobuf::service::navigationstatus::message::NavigationStatus&)> onNavigationStatus;
  std::function<void(const aap_protobuf::service::navigationstatus::message::NavigationNextTurnEvent&)> onNavigationTurn;
  std::function<void(const aap_protobuf::service::navigationstatus::message::NavigationNextTurnDistanceEvent&)> onNavigationDistance;
};

void setEventCallbacks(EventCallbacks callbacks);
EventCallbacks getEventCallbacks();

}  // namespace f1x::openauto::autoapp::service
