class MinHeap:
    def __init__(self, count_param: int = 3):
        self.count_param = count_param # s_score, current_time, transfers,
        self.data = []

    def push(self, item):
        self.data.append(item)
        last_index_item = len(self.data) - 1
        self._sift_up(last_index_item)

    def pop(self):
        if not self.data:
            return None
        self.data[0], self.data[-1] = self.data[-1], self.data[0]
        item = self.data.pop()
        self._sift_down(0)
        return item

    def _sift_up(self, index):
        parent = (index - 1) // 2
        while index > 0:
            if self.data[parent][:self.count_param] > self.data[index][:self.count_param]:
                self.data[index], self.data[parent] = self.data[parent], self.data[index]
                index = parent
                parent = (index - 1) // 2
            else:
                break

    def _sift_down(self, parent):
        left_child = 2 * parent + 1
        max_index = len(self.data)
        while left_child < max_index:
            right_child = left_child + 1
            left_child = self._get_smaller_child_index(right_child, left_child)

            if self.data[parent][:self.count_param] > self.data[left_child][:self.count_param]:
                self.data[parent], self.data[left_child] = self.data[left_child], self.data[parent]
                parent = left_child
                left_child = 2 * parent + 1
            else:
                break

    def _get_smaller_child_index(self, right_child_idx, left_child_idx):
        if right_child_idx < len(self.data) and self.data[right_child_idx][:self.count_param] < self.data[left_child_idx][:self.count_param]:
            left_child_idx = right_child_idx
        return left_child_idx