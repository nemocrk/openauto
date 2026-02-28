#include <f1x/openauto/autoapp/Service/Callbacks.hpp>

namespace f1x::openauto::autoapp::service {

namespace {
std::mutex g_callbacks_mutex;
EventCallbacks g_callbacks;
}  // namespace

void setEventCallbacks(EventCallbacks callbacks) {
  std::lock_guard<std::mutex> lock(g_callbacks_mutex);
  g_callbacks = std::move(callbacks);
}

EventCallbacks getEventCallbacks() {
  std::lock_guard<std::mutex> lock(g_callbacks_mutex);
  return g_callbacks;
}

}  // namespace f1x::openauto::autoapp::service
