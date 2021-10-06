import time
import argparse
import torch

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--delay', type=int, default=1)
    parser.add_argument('--size', type=int, default=40000)
    parser.add_argument('--device', type=str, default='cuda')
    args = parser.parse_args()

    device = torch.device(args.device)
    while True:
        for i in range(100):
            m1 = torch.rand((args.size, args.size)).to(device, non_blocking=True)
            m2 = torch.rand((args.size, args.size)).to(device, non_blocking=True)
            torch.matmul(m1, m2)
        time.sleep(args.delay)
