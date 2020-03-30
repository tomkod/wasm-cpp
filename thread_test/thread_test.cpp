#include <iostream>
#include <utility>
#include <thread>
#include <chrono>
#include <atomic>

#if 1 //__EMSCRIPTEN__
  // FIXME: atomics doesn't work
  using counter_t = int;
#else
  using counter_t = std::atomic<int>;
#endif


void run_thread(int id, int sleep_time, counter_t& counter)
{
  for (int i = 0; i < 5; ++i) {
    std::cout << "Thread " << i
      << " sleep " << sleep_time << "ms\n";
    std::this_thread::sleep_for(
      std::chrono::milliseconds(sleep_time));
    ++counter;
  }
}
 
int main()
{
    counter_t counter(0);
    std::thread t1(run_thread, 0, 100, std::ref(counter));
    std::thread t2(run_thread, 1, 60, std::ref(counter));
    t1.join();
    t2.join();
    std::cout << "Final value of counter is " << counter << '\n';
}
